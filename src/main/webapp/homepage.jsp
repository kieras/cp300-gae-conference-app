<%@ include file="header.jsp" %>
<h1>Welcome to Conference Central</h1>

<p>You can schedule conferences and register for conferences right here on this web site. 
We have a range of venues for conferences in some of the nicest places in the world.</p>

<%   
  // If YES:
  // greet them by name 
  // display a message indicating if they are logged in as a developer (admin) or not
  // display a logout link
    if (userPrincipal != null) { %>
        <p>Hi <%= userPrincipal.getName() %>.</p> <%
        if (userService.isUserAdmin()) { %>
            YOU ARE AN ADMIN! <%
        }
    }

  // If NO:
  // Display a login link
    if (userPrincipal == null) {
       String loginLink = userService.createLoginURL(requestUri); %>
       <p><a href="<%= loginLink %>">Sign In</a></p>  <%
    }
%>

   <!--  Print links to other pages -->
   <p><a href="/scheduleconference">Schedule a conference</a></p>
   <p><a href="/listconferences">List conferences</a></p>
   <p><a href="/userprofile">Go to your user profile</a></p>
   <p><a href="/venues">Browse our delightful venues</a></p>

<%@ include file="footer.jsp" %>