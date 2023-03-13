package com.example.shield;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class profile extends AppCompatActivity {

    private TextView login , number , gender , fnumber , gnumber ;
    private ImageView profile ;
    private String Name , Mobile ;
    DbHelper db ;

    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);

        login = findViewById(R.id.login);
        number = findViewById(R.id.number);
        gender = findViewById(R.id.gender);
        fnumber = findViewById(R.id.fnumber);
        gnumber = findViewById(R.id.gnumber);
        profile = findViewById(R.id.profile);

        db = new DbHelper(this) ;

        Cursor cursor = db.select() ;
        if(cursor.getCount() == 0)
        {
            login.setText("Login");
        }
        while(cursor.moveToNext())
        {
            login.setText(cursor.getString(1));
            number.setText(cursor.getString(2));
            gender.setText(cursor.getString(3));
            fnumber.setText(cursor.getString(4));
            gnumber.setText(cursor.getString(5));
        }

        Toast.makeText(this, "Click Person icon to edit your details....", Toast.LENGTH_LONG).show();

        profile.setOnClickListener(v -> {
            Intent intent1 = new Intent(profile.this , edit_section.class) ;
            String Gender = gender.getText().toString().trim() ;
            intent1.putExtra("Gender" , Gender) ;
            startActivity(intent1);
            finish();
        });
    }
}