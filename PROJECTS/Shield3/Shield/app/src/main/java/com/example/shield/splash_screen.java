package com.example.shield;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.widget.Toast;

public class splash_screen extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash_screen);

        new Handler().postDelayed(() -> {

            SharedPreferences sharedPreferences = getSharedPreferences(Register_Page.PRFS_NAME , 0) ;
            boolean hasLoggedIn = sharedPreferences.getBoolean("hasLoggedIn" , false) ;

            if(hasLoggedIn)
            {
                Intent intent = new Intent(splash_screen.this , home.class) ;
                startActivity(intent);
                finish();
                Toast.makeText(this, "Keep On Location Anytime....", Toast.LENGTH_LONG).show();
            }

            else
            {
                Intent intent = new Intent(splash_screen.this , Register_Page.class) ;
                startActivity(intent);
                finish();
            }
        }, 1000) ;
    }
}