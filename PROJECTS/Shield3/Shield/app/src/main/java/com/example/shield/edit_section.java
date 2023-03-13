package com.example.shield;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

@SuppressWarnings(value = "ALL")
public class edit_section extends AppCompatActivity {
    
    DbHelper db ;
    private EditText name , mobile , fmobile , gmobile , message ;
    private Spinner gender ;

    @SuppressLint("CutPasteId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_section);

        Button updatebutton = (Button) findViewById(R.id.updatebutton);
        name = (EditText) findViewById(R.id.name) ;
        mobile = (EditText) findViewById(R.id.mobile) ;
        fmobile = (EditText) findViewById(R.id.fmobile) ;
        gmobile = (EditText) findViewById(R.id.gmobile) ;
        message = (EditText) findViewById(R.id.message) ;

        gender = (Spinner) findViewById(R.id.gender) ;

        db = new DbHelper(this) ;

        Cursor cursor = db.select() ;

        while(cursor.moveToNext())
        {
            message.setText(cursor.getString(6));
        }

        String Msg = message.getText().toString().trim() ;

        String[] genders = getResources().getStringArray(R.array.Gender);

        Spinner spin = findViewById(R.id.gender);

        ArrayAdapter array = new ArrayAdapter(edit_section.this, android.R.layout.simple_spinner_item, genders);
        array.setDropDownViewResource(android.R.layout.simple_list_item_single_choice) ;

        spin.setAdapter(array);

        updatebutton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String Name = name.getText().toString().trim() ;
                String Mobile = mobile.getText().toString().trim() ;
                String FMobile = fmobile.getText().toString().trim() ;
                String GMobile = gmobile.getText().toString().trim() ;
                String Gender = gender.getSelectedItem().toString().trim() ;
                String Message ;

                if(Msg == message.getText().toString().trim())
                {
                    Message = Msg;
                }
                else
                {
                    Message = message.getText().toString().trim() ;
                }

                if(gender.getSelectedItem().toString().equals("Select Gender"))
                {
                    Toast.makeText(getApplicationContext() , "Select Your Gender" , Toast.LENGTH_LONG).show();
                }
                else
                {
                    db.update(Name , Mobile , Gender , FMobile , GMobile , Message) ;

                    Toast.makeText(edit_section.this, "Updated Successfully...", Toast.LENGTH_SHORT).show();

                    Intent intent = new Intent(edit_section.this , profile.class) ;
                    startActivity(intent) ;
                    finish();
                }
            }
        });
    }
}