package com.example.shield;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.LocationRequest ;

import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.SettingsClient;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.button.MaterialButton;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@SuppressWarnings("ALL")
public class home extends AppCompatActivity implements LocationListener {
private ImageView homeicon , personicon , fingerprint;
private MaterialButton updatebutton ;
    private TextView textView , textView2 , textView3 , textView4 , textView5;
    LocationManager locationManager ;

    DbHelper db ;
    private String Number1 , Number2 , Name , Message , Mobile ;
    private static final int REQUEST_CHECK_SETTINGS = 0x1 ;

    private String lattitude , longtitude , country , locality , address , link ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        homeicon = findViewById(R.id.homeicon);
        personicon = findViewById(R.id.personicon);
        fingerprint = findViewById(R.id.fingerprint);

        textView = findViewById(R.id.textView) ;
        textView2 = findViewById(R.id.textView2) ;
        textView3 = findViewById(R.id.textView3) ;
        textView4 = findViewById(R.id.textView4) ;
        textView5 = findViewById(R.id.textView5) ;
        updatebutton = findViewById(R.id.updatebutton);

        db = new DbHelper(this) ;

        Check(Manifest.permission.SEND_SMS , 100) ;

        ActivityCompat.requestPermissions(this , new String[] {Manifest.permission.ACCESS_FINE_LOCATION ,
                Manifest.permission.ACCESS_COARSE_LOCATION} , PackageManager.PERMISSION_GRANTED);

        locationManager = (LocationManager) getApplicationContext().getSystemService(LOCATION_SERVICE) ;

        homeicon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                textView.setText("Lattitude");
                textView2.setText("Longtitude");
                textView3.setText("Country Name");
                textView4.setText("Locality");
                textView5.setText("Address Line");
            }
        });

        personicon.setOnClickListener(v -> {
            Intent intent1 = new Intent(home.this , profile.class) ;
            startActivity(intent1);
        });

        updatebutton.setOnClickListener(v -> {
            LocationRequest locationRequest = LocationRequest.create() ;
            locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY) ;
            locationRequest.setInterval(1000) ;
            locationRequest.setFastestInterval(1000 / 2) ;

            LocationSettingsRequest.Builder locationSettingsBuilder = new LocationSettingsRequest.Builder();
            locationSettingsBuilder.addLocationRequest(locationRequest) ;
            locationSettingsBuilder.setAlwaysShow(true) ;

            SettingsClient settingsClient = LocationServices.getSettingsClient(this) ;

            getLocation() ;

            Task<LocationSettingsResponse> task = settingsClient.checkLocationSettings(locationSettingsBuilder.build());

            task.addOnSuccessListener(this, new OnSuccessListener<LocationSettingsResponse>() {
                @Override
                public void onSuccess(LocationSettingsResponse locationSettingsResponse) {

                }
            }) ;
            task.addOnFailureListener(this, new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    if(e instanceof ResolvableApiException)
                    {
                        try {
                            ResolvableApiException resolvableApiException = (ResolvableApiException) e ;
                            resolvableApiException.startResolutionForResult(home.this , REQUEST_CHECK_SETTINGS);
                        }
                        catch (Exception e1)
                        {
                            e1.printStackTrace();
                        }
                     }
                }
            });
            Toast.makeText(home.this, "Please Wait until the Locations were appeared.", Toast.LENGTH_LONG).show();

        });
        fingerprint.setOnClickListener(v -> {

            Cursor cursor = db.select() ;
            while(cursor.moveToNext())
            {
                Name = cursor.getString(1) ;
                Mobile = cursor.getString(2) ;
                Number1 = cursor.getString(4) ;
                Number2 = cursor.getString(5) ;
                Message  = cursor.getString(6) ;
            }

            lattitude = textView.getText().toString() ;
            longtitude = textView2.getText().toString() ;
            country = textView3.getText().toString() ;
            locality = textView4.getText().toString() ;
            address = textView5.getText().toString() ;
            link = "https://www.google.com/maps/place/"+lattitude+","+longtitude+"/@"+lattitude+","+longtitude+"/data=!3m1!4b1" ;

            ArrayList<String> arrayList = new ArrayList<String>() ;
            arrayList.add("My Name is : "+Name+"\n") ;
            arrayList.add("My Mobile Number is : "+Mobile+"\n") ;
            arrayList.add(Message+"\n") ;
            arrayList.add("Lattitude : "+lattitude+"\n") ;
            arrayList.add("Longtitude :"+longtitude+"\n") ;
            arrayList.add("Country : "+country+"\n") ;
            arrayList.add("Locality : "+locality+"\n") ;
            arrayList.add("Address : "+address+"\n\n") ;
            arrayList.add(link) ;

            SmsManager smsManager = SmsManager.getDefault() ;
            smsManager.sendMultipartTextMessage(Number1 , null , arrayList, null , null );
            smsManager.sendMultipartTextMessage(Number2 , null , arrayList, null , null);
            Toast.makeText(home.this , "Message Sent Successfully" , Toast.LENGTH_LONG).show();
        });
    }

    private void getLocation() {
        locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER , 1000 , 1 , home.this);
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER , 1000 , 1 , home.this);
    }

    private void Check(String sendSms, int i) {
        if(ContextCompat.checkSelfPermission(home.this , sendSms) == PackageManager.PERMISSION_DENIED)
        {
            ActivityCompat.requestPermissions(home.this , new String[]{sendSms} , i);
        }
    }

    @Override
    public void onLocationChanged(@NonNull Location location) {

        try {
            Geocoder geocoder = new Geocoder(home.this , Locale.getDefault()) ;
            List<Address> addressList = geocoder.getFromLocation(location.getLatitude() , location.getLongitude() , 1) ;
            double lattitude1 = addressList.get(0).getLatitude();
            double longtitude1 = addressList.get(0).getLongitude();
            String country1 = addressList.get(0).getCountryName();
            String locality1 = addressList.get(0).getLocality();
            String address1 = addressList.get(0).getAddressLine(0);

            textView.setText(String.valueOf(lattitude1));
            textView2.setText(String.valueOf(longtitude1));
            textView3.setText(country1);
            textView4.setText(locality1);
            textView5.setText(address1);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {
    }

    @Override
    public void onProviderEnabled(@NonNull String provider) {
    }

    @Override
    public void onProviderDisabled(@NonNull String provider) {
    }
}