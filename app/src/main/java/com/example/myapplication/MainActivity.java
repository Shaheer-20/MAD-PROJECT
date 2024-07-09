package com.example.myapplication;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.TextView;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import com.github.barteksc.pdfviewer.PDFView;
import org.apache.commons.io.IOUtils;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class MainActivity extends AppCompatActivity {

    private static final int PICK_FILE_REQUEST = 1;
    private Button openDocumentButton;
    private FrameLayout documentContainer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        openDocumentButton = findViewById(R.id.openDocumentButton);
        documentContainer = findViewById(R.id.documentContainer);

        openDocumentButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openFilePicker();
            }
        });
    }

    private void openFilePicker() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("*/*");
        startActivityForResult(intent, PICK_FILE_REQUEST);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PICK_FILE_REQUEST && resultCode == RESULT_OK && data != null) {
            Uri fileUri = data.getData();
            handleFile(fileUri);
        }
    }

    private void handleFile(Uri fileUri) {
        String mimeType = getContentResolver().getType(fileUri);
        documentContainer.removeAllViews();

        if (mimeType != null && mimeType.equals("application/pdf")) {
            PDFView pdfView = new PDFView(this, null);
            pdfView.setLayoutParams(new FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.MATCH_PARENT
            ));
            documentContainer.addView(pdfView);
            pdfView.fromUri(fileUri).load();
        } else if (mimeType != null && mimeType.equals("text/xml")) {
            TextView textView = new TextView(this);
            textView.setLayoutParams(new FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.MATCH_PARENT
            ));
            documentContainer.addView(textView);
            try {
                InputStream inputStream = getContentResolver().openInputStream(fileUri);
                String xmlContent = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
                textView.setText(xmlContent);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            TextView textView = new TextView(this);
            textView.setLayoutParams(new FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.MATCH_PARENT
            ));
            documentContainer.addView(textView);
            textView.setText("Unsupported file type: " + mimeType);
        }
    }
}
