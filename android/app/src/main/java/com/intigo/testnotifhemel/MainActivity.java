package com.intigo.testnotifhemel;
import android.content.Intent;
import android.util.Log;
import android.content.SharedPreferences;
import 	android.preference.PreferenceManager;
import io.flutter.embedding.android.FlutterActivity;
import 	org.json.JSONObject;
import 	org.json.JSONException;
import android.content.SharedPreferences.Editor;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.UriPermission;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.storage.StorageManager;
import android.os.storage.StorageVolume;
import android.provider.DocumentsContract;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.documentfile.provider.DocumentFile;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.io.File;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "android_app_retain";
    private MethodChannel methodChannel;


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.setMethodCallHandler(
                (methodCall, result) -> {
                    Map<String, Object> arguments = methodCall.arguments();
                    android.util.Log.d("TAGTAGTAGTAG", "configureFlutterEngine: "+methodCall.method);
                    if (methodCall.method.equals("wakeFromBackground")) {
                        wakeupfrombackground(getApplicationContext());
                    }
                }
        );
    }

    public void wakeupfrombackground(Context context) {
        android.util.Log.d("TAGTAGTGTAGTAG", "wakeupfrombackground: LOGGGGGGGGING WOOOOOOOOOOOO");
        Intent closeDialog = new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
        context.sendBroadcast(closeDialog);
        String packageName = context.getPackageName();
        PackageManager pm = context.getPackageManager();
        Intent launchIntent = pm.getLaunchIntentForPackage(packageName);
        context.startActivity(launchIntent);
    }

}

