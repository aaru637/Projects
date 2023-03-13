package com.example.shield;

import androidx.appcompat.app.AppCompatActivity;


import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;


@SuppressWarnings("ALL")
public class Register_Page extends AppCompatActivity {

    public static String PRFS_NAME = "MyPrefsFile" ;

    private EditText name , mobile , fmobile , gmobile ;
    private Spinner gender ;
    private String NAME , MOBILE , GENDER , FMOBILE , GMOBILE , MESSAGE ;

    DbHelper db ;


    @SuppressLint("CutPasteId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register_page);

        Button registerbutton = findViewById(R.id.registerbutton);

        name = (EditText) findViewById(R.id.name) ;
        mobile = (EditText) findViewById(R.id.mobile) ;
        gender = (Spinner) findViewById(R.id.gender) ;
        fmobile = (EditText) findViewById(R.id.fmobile) ;
        gmobile = (EditText) findViewById(R.id.gmobile) ;

        db = new DbHelper(this) ;


        String[] genders = getResources().getStringArray(R.array.Gender);

        Spinner spin = findViewById(R.id.gender);

        ArrayAdapter array = new ArrayAdapter(Register_Page.this , android.R.layout.simple_spinner_item , genders) ;
        array.setDropDownViewResource(android.R.layout.simple_list_item_single_choice) ;

        spin.setAdapter(array);

        registerbutton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Cursor cursor = db.select() ;

                NAME = name.getText().toString().trim();
                MOBILE = mobile.getText().toString().trim();
                GENDER = gender.getSelectedItem().toString().trim();
                FMOBILE = fmobile.getText().toString().trim();
                GMOBILE = gmobile.getText().toString().trim();
                MESSAGE = "I'm in Danger. Please Help Me . I was stucked in the below location." ;

                SharedPreferences sharedPreferences = getSharedPreferences(Register_Page.PRFS_NAME , 0) ;
                SharedPreferences.Editor editor = sharedPreferences.edit() ;



                if (NAME.equals("")) {
                    Toast.makeText(getApplicationContext() , "Enter Your Name...." , Toast.LENGTH_LONG).show();
                }
                else if(MOBILE.equals(""))
                {
                    Toast.makeText(getApplicationContext() , "Enter Your Mobile No...." , Toast.LENGTH_LONG).show();
                }
                else if(GENDER.equals("Select a Gender"))
                {
                    Toast.makeText(getApplicationContext() , "Select Your Gender...." , Toast.LENGTH_LONG).show();
                }
                else {
                    editor.putBoolean("hasLoggedIn" , true) ;
                    editor.commit() ;
                    Boolean insert = db.insert(NAME , MOBILE , GENDER , FMOBILE , GMOBILE , MESSAGE) ;

                    if(insert == true)
                    {
                        Toast.makeText(getApplicationContext() , "Registered." , Toast.LENGTH_LONG).show();
                        Intent intent = new Intent(Register_Page.this , home.class) ;
                        startActivity(intent);
                    }
                }
            }
        });
    }
}