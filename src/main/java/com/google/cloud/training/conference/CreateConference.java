package com.google.cloud.training.conference;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CreateConference extends HttpServlet {

  public static final Logger _LOG = Logger.getLogger(CreateConference.class.getName());

  // Get a handle to the DatastoreService
  public static DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {


    PrintWriter writer = resp.getWriter();


    // Get the values sent by the form
    String title = req.getParameter("title");
    String city = req.getParameter("city");
    String maxAttendees = req.getParameter("maxAttendees");
    String confStartDate = req.getParameter("startdate");
    String confEndDate = req.getParameter("enddate");


    try {
      // Convert maxAttendees to a Long before saving it
      Long mL = Long.parseLong(maxAttendees);


      // Convert the startDate and endDate to Dates
      // The format is 2013-04-26


      Date startDate;
      try {
        startDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(confStartDate);
      } catch (ParseException e) {
        startDate = null;
      }
      Date endDate;
      try {
        endDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(confEndDate);
      } catch (ParseException e) {
        endDate = null;
      }

      // Create an entity of kind "Conference"
      Entity confEntity = new Entity("Conference");

      confEntity.setProperty("title", title);
      confEntity.setProperty("city", city);
      confEntity.setProperty("maxAttendees", mL);
      confEntity.setProperty("startdate", startDate);
      confEntity.setProperty("enddate", endDate);

      // Save the entity in the datastore
      Key confKey = datastore.put(confEntity);

      // Get a string of the conference entity's key
      String confKeyString = KeyFactory.keyToString(confKey);
      _LOG.info("Conference Entity with Key = " + confKeyString + " created");

      resp.sendRedirect("/");
    } catch (Exception e) {
      resp.setContentType("text/html");
      writer.println("Exception in saving entity. Reason : " + e.getMessage());
    }
  }


  /*
   * If a user comes to this page as a GET, redirect to the Create Conference page
   */
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    resp.sendRedirect("/createconference");
  }
}
