<html>
<%@page import="data.FB_Data"%>
<head>
    <style>
        h4 {color: white; font-family: Arial}
    </style>
</head>
<body background="fb.jpeg">
<%FB_Data fp = (FB_Data)request.getAttribute(FB_Data.AUTH);  %>
<div style="width:400px;margin:auto;padding-top:30px; align-content: center; color: white">
    <h2>Facebook Data of <%=fp.getName()%></h2>
    <table>
        <tr>
            <td></td>
            <td><img src="http://graph.facebook.com/<%=fp.getId()%>/picture"/></td>
        </tr>
        <tr>
            <td><br><h4>UserID:</td>
            <td><br><h4><%=fp.getId()%></td>
        </tr>
        <tr>
            <td><br><h4>Gender:</td>
            <td><br><h4><%=fp.getGender()%></td>
        </tr>
        <tr>
            <td><br><h4>Link:</td>
            <td><br><a href="<%=fp.getLink()%>">Click here to view <%=fp.getName()%>'s profile</a></td>
        </tr>
        <tr>
            <td><br><h4>Name:</td>
            <td><br><h4><%=fp.getName()%></td>
        </tr>
    </table>
    <video width="320" height="240" autoplay>
        <source src="demo.mp4" type="video/mp4">
    </video>
</div>
</body>
</html>