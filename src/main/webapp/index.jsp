<%@ page import="java.util.*" %>
<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="com.google.appengine.api.datastore.Query.*" %>
<%@ page import="java.text.DateFormat" %>


<% 
    // Get a handle to the datastore service
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    // Create the Query to get all the conferences
    Query confQuery = new Query("Conference");   
    confQuery.addSort("title", SortDirection.ASCENDING); 
    // Submit the query
     PreparedQuery results = datastore.prepare(confQuery);
  %>
  <!DOCTYPE html>
<html>
  <h1>Conference List</h1>
  <body>
      <table border="1">
  <tr><th>Conference Title</th><th>City</th><th>Max Attendees</th><th>Start Date</th><th>End Date</th></tr>
	  <%
	            if (results != null) {
	  	for (Entity conference : results.asIterable()) {
	  	     String title = conference.getProperty("title").toString();
	                   String city = conference.getProperty("city").toString();
	      	     String maxAttendees = conference.getProperty("maxAttendees").toString();
	      	    // Get the start and end date.
	      	   // Check the dates exist, and then convert them to a printable format.
	      	   String startDateString = "";
	      	   Date startDate = (Date) conference.getProperty("startdate");
	      	   if (startDate != null) {
	      	    startDateString =  DateFormat.getDateInstance(DateFormat.MEDIUM)
                                                                                      .format(startDate);
	                  }
    		   String endDateString = "";
	      	   Date endDate = (Date) conference.getProperty("enddate");
	      	   if (endDate != null) {
	      		endDateString = DateFormat.getDateInstance(DateFormat.MEDIUM)
                                                                                                                              .format(endDate);
	      	   }
      		%>
                  <tr>
	    <td><%=title%></td>
		<td><%=city%></td>
		<td><%=maxAttendees%></td>
		<td><%=startDateString%></td>
		<td><%=endDateString%></td>
            </tr>
      	  <%
                   }	
                  }
          %>
</table>

<h1>Schedule new Conference</h1>


  <form action="/create" method="post">
	  <p><b>What is the title of your conference? </b><input name="title" size="30"/></p>
	  
	  <p><b>Where would you like to hold your conference? </b><input name="city" size="30"> 
		</input></p>
		  
	  <p><b>What is the maximum number of attendees? </b>
	  <input name="maxAttendees" value="5" /><i>Must be an integer</i></p>


	  <p><b>What date does your conference start? </b><input name="startdate" type="date">
	  
	  <p><b>What date does your conference end? </b><input name="enddate" type="date"></p>

	  <p><input type=submit value="Schedule conference" id=scheduleconference /></p>
  </form>
  </body>
</html>