package com.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.net.URLEncoder;
import java.util.Base64;
import com.google.gson.Gson;
import data.FB_Data;
import org.apache.http.client.methods.HttpPost;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.HttpResponse;
import java.io.Reader;
import org.apache.http.NameValuePair;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;

@WebServlet(name = "Request")
public class Request extends HttpServlet {
    public Request() throws IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Authorization code response
            String authCode = request.getParameter("code");
            if (authCode != null) {
                //Access token request
                String CLIENT_ID = "2088508851400874";
                String APP_SECRET = "87ba152515a6563068e12f58ed1c9085";
                String GRANT_TYPE = "authorization_code";
                String FB_TOKEN_ENDPOINT = "https://graph.facebook.com/oauth/access_token";
                String URI = "https://localhost:8443/callback";
                HttpPost httpCon = new HttpPost(FB_TOKEN_ENDPOINT + "?" + "client_id=" + URLEncoder.encode(CLIENT_ID) + "&" + "code=" + URLEncoder.encode(authCode) + "&" +
                        "redirect_uri=" + URLEncoder.encode(URI) + "&" + "grant_type=" + URLEncoder.encode(GRANT_TYPE));
                //Authorization header
                byte[] header = (CLIENT_ID + ":" + APP_SECRET).getBytes();
                String enHeader = new String(Base64.getEncoder().encodeToString(header));
                httpCon.setHeader("Authorization", "Basic " +
                        enHeader);
                //Making request
                CloseableHttpClient httpClient =
                        HttpClients.createDefault();
                HttpResponse httpResponse = httpClient.execute(httpCon);
                Reader reader = new InputStreamReader
                        (httpResponse.getEntity().getContent());
                BufferedReader bufferedReader = new BufferedReader(reader);
                String line = bufferedReader.readLine();
                //Extracting Access token from the response
                String accessToken = null;
                String[] responseProperties = line.split("&");
                for (String responseProperty : responseProperties) {
                    System.out.println(responseProperty);
                    try {
                        JSONParser parser = new JSONParser();
                        Object obj = parser.parse(responseProperty);
                        JSONObject jsonobj = (JSONObject) obj;
                        accessToken = jsonobj.get("access_token").toString();
                        System.out.println("Access token: " + accessToken);

                    } catch (ParseException e) {
                        System.out.println("Error : " + e.getMessage());
                    }

                }
                //Requesting user data
                String requestUrl = "https://graph.facebook.com/v3.1/me?fields=id,name,gender,link,photos";
                httpCon = new HttpPost(requestUrl);
                httpCon.addHeader("Authorization", "Bearer " + accessToken);
                List<NameValuePair> urlParameters = new
                        ArrayList<NameValuePair>();
                urlParameters.add(new BasicNameValuePair("method", "get"));
                httpCon.setEntity(new UrlEncodedFormEntity(urlParameters));
                httpResponse = httpClient.execute(httpCon);
                //Holding the Json response
                bufferedReader = new BufferedReader(
                        new InputStreamReader(httpResponse.getEntity().getContent()));
                String feedJson = bufferedReader.readLine();
                //Output the Json response - used for debugging purposes
                System.out.println("Facebook Response data: " + feedJson);
                //Parsing Json data to Index.jsp
                FB_Data fb = (FB_Data)new Gson().fromJson(feedJson, FB_Data.class);
                System.out.println(fb);
                request.setAttribute("auth", fb);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                //Closing the connection
                httpClient.close();
            }
        }

     catch(Exception e){
        e.printStackTrace();
    }
  }
}
