package com.appswitcher;

import android.app.Activity;
import android.view.WindowManager;
import android.widget.Toast;

import android.graphics.Color;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.renderscript.Allocation;
import android.renderscript.RenderScript;
import android.renderscript.ScriptIntrinsicBlur;
import android.view.View;
import android.view.ViewTreeObserver;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class AppSwitcherPrivacy extends CordovaPlugin {
    private static final String ACTION_BLOCK = "block";
    private static final String ACTION_UNBLOCK = "unblock";
    private AppSwitcherPrivacy pluginContext;

    LinearLayout layout;
    FrameLayout frameLayout;
    boolean featureEnabled = false;
    boolean shouldBlock = false;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        frameLayout = (FrameLayout) webView.getView().getParent();
        layout = new LinearLayout(this.cordova.getActivity().getApplicationContext());
        layout.setLayoutParams(
            new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        );
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setBackgroundColor(Color.parseColor("#000000"));
    }

    @Override
    public boolean execute(
        String action,
        JSONArray data,
        final CallbackContext callbackContext
    ) throws JSONException {
        pluginContext = this;
        if (action.equals(ACTION_UNBLOCK)) {
            unblockAppSwitcher(callbackContext);
            return true;
        } else if (action.equals(ACTION_BLOCK)) {
            blockAppSwitcher(callbackContext);
            return true;
        } else return false;
    }

    @Override
    public void onPause(boolean multitasking) {
        if (shouldBlock) {
            frameLayout.addView(layout);
            featureEnabled = true;
        }
    }

    @Override
    public void onResume(boolean multitasking) {
        if (featureEnabled) {
            frameLayout.removeView(layout);
            featureEnabled = false;
        }
    }

    private void showMessage(String text) {
        Toast.makeText(
            this.cordova.getActivity().getApplicationContext(),
            text,
            Toast.LENGTH_SHORT
        ).show();
    }

    private void blockAppSwitcher(final CallbackContext callbackContext) {
        shouldBlock = true;
        callbackContext.success("{\"message\": \"AppSwitcher view Blocked\"}");
    }

    private void unblockAppSwitcher(final CallbackContext callbackContext) {
        shouldBlock = false;
        callbackContext.success("{\"message\": \"AppSwitcher view enabled\"}");
    }
}
