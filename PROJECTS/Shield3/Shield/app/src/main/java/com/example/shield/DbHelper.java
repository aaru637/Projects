package com.example.shield;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DbHelper extends SQLiteOpenHelper {

    public DbHelper(Context context) {
        super(context, "DK.db", null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("create table if not exists DHINESH(S_No INTEGER , Name TEXT NOT NULL, Mobile TEXT PRIMARY KEY , Gender TEXT , FMobile TEXT , GMobile TEXT , Message TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("drop table if exists DHINESH");
    }

    public Boolean insert(String Name , String Mobile , String Gender , String FMobile , String GMobile , String Message)
    {
        SQLiteDatabase db = this.getWritableDatabase() ;
        ContentValues contentValues = new ContentValues() ;
        contentValues.put("S_No" , 1);
        contentValues.put("Name", Name) ;
        contentValues.put("Mobile" , Mobile) ;
        contentValues.put("Gender" , Gender) ;
        contentValues.put("FMobile" , FMobile) ;
        contentValues.put("GMobile" , GMobile) ;
        contentValues.put("Message" , Message);
        long result = db.insert("DHINESH" , null , contentValues) ;
        return result != -1;
    }

    public Cursor select()
    {
        SQLiteDatabase db = this.getWritableDatabase() ;
        return db.rawQuery("select * from DHINESH" , null);
    }

    public void update(String Name, String Mobile, String Gender, String FMobile, String GMobile , String Message)
    {
        SQLiteDatabase db = this.getWritableDatabase() ;
        ContentValues contentValues = new ContentValues() ;

        if(!(Name.equals("")))
        {
            contentValues.put("Name" , Name);
        }
        if(!(Gender.equals("")))
        {
            contentValues.put("Gender" , Gender);
        }
        if(!(Mobile.equals("")))
        {
            contentValues.put("Mobile" , Mobile);
        }
        if(!(FMobile.equals("")))
        {
            contentValues.put("FMobile" , FMobile) ;
        }
        if(!(GMobile.equals("")))
        {
            contentValues.put("GMobile" , GMobile) ;
        }
        if(!(Message.equals("")))
        {
            contentValues.put("Message" , Message);
        }
        Integer S_No = 1 ;

        db.update("DHINESH" , contentValues , "S_No = ?" , new String[]{String.valueOf(S_No)}) ;

    }
}
