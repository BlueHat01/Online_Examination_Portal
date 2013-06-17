<%-- 
    Document   : PreviousResults
    Created on : Jul 21, 2012, 2:12:36 AM
    Author     : Devanand
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Previous Results - Online Examination Portal</title>
    <link href="menuStyle.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
      <%   
HttpSession Usersession = request.getSession(false);
if(Usersession.getAttribute("Username") == null || Usersession.getAttribute("Privilage") == null)
       {
   response.sendRedirect("index.html");
      

}
else
       {
    %>
    <h2 class="Page-Heading">Online Examination Portal</h2>  
    <%
    out.println("<b>Welcome "+Usersession.getAttribute("Username")+"...</b>");
%>
<div id="navigation">
			<ul>
            	<li><a href="home.jsp">Home</a></li>
                <%
                if(Usersession.getAttribute("Privilage").toString().contains("adminUser"))
         {
     out.println("<li><a href = 'AdminConsoleHome.jsp'>Administration Console</a></li>");
 }
                %>
                <li><a href="main.jsp">Available Exams</a></li>
                <li id="active"><a href="PreviousResults.jsp">Previous Results</a></li>
                <li><a href="ContactUs.jsp">Contact Us</a></li>
                <li><a href="Logout.jsp">Logout</a></li>
		</ul>
	</div>    

                <table border="0" width="950">
                    <tr>
                        <td align ="center">
                            
                                <%
           
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
             Connection con=DriverManager.getConnection("jdbc:odbc:Online_Exam_Portal","","");
             Statement ps=con.createStatement();

             ResultSet rs;
             
                     rs=ps.executeQuery("Select * from Exam_Results where UserId = "+Usersession.getAttribute("UserId")+" order by TimeStamp desc"); 
                     rs.setFetchDirection(ResultSet.FETCH_UNKNOWN);
             int ExamId;
             int bgcolorFlag = 0;
if(rs.next())
       {
  

%>
<h2 style="color: #4778e3">Here's a summary of the Exams you've attempted so far... </h2>
                            <table border ="0" width="800" cellpadding="15" cellspacing="0">
                                <tr  style="background-color: #a9a8f0; font-size: 20px; font-weight: bold">
                                <td align="center">
                                    <b>UEID</b>
                                </td>
                                <td align="center">
                                    <b>Exam ID</b>
                                </td>
                                <td align="center">
                                    <b>Exam Title</b>
                                </td>
                                <td align="center">
                                    <b>Marks Scored</b>
                                </td>
                                <td align="center">
                                    <b>Date of Test</b>
                                </td>
                                </tr>
<%

           do
            {
           bgcolorFlag++;
%>
<tr style="background-color:<% if((bgcolorFlag%2)==0) out.print("#cac9f2"); else out.print("#e1e1f0");
%>">
    <td align="center"><% out.print(rs.getString("UEID")); %></td>
<td align="center"><% out.print(rs.getInt("ExamId")); %></td>
<td align="center"><% out.print(rs.getString("ExamName")); %></td>
<td align="center"><% out.print(rs.getInt("MarksScored")); %> /100</td>
<td align="center"><% out.print(rs.getString("TimeStamp")); %></td>
</tr>
<%
           }while(rs.next());
}
             else
                                 {
%>
<h2 style="padding-top: 20px">It seems you have not attempted any of our Examinations yet...</h2>
<h4>Go to the Available Exams tab to take a test.</h4>
                            </table>
                            
                        </td>
                    </tr>
                </table>
                  <%
   }
       }
%>      
    </body>
</html>
