<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="Connection.Base64"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="Connection.dbconnection"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PRC Notice Board</title>
        <meta http-equiv="refresh" content="30">
        <link rel = "icon" href ="https://providence.edu.in/wp-content/uploads/2021/06/CSE_White.png" type = "image/x-icon">
    
    </head>

    <style>
        * {
            margin: 0;
        }
        body{
         background:whitesmoke;
        }

        header {
            height: 150px;
            background: rgb(204,8,35);
            background: linear-gradient(90deg, rgba(204,8,35,1) 0%, rgba(15,1,7,1) 74%, rgba(204,8,35,1) 100%);
            font-size: 30px;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }
        h4{
            color: white;
            font-size: 30px;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            text-align: center;
        }
        .cardbox {
            padding: 10px;
            display: flex;
            gap: 20px 10px;
        }
        p{
            font-size: 24px;
            text-align: center;
            padding: 20px;        
            color: black    ;
            font-weight: bold;

        }
        .studernt{
            margin: 0;
            width: 48%;
            padding: 10px;
        }
        .faculty{
            width: 48%;
            padding: 10px;
        }
        .scard,.fcard{
            padding: 20px;
            text-align: justify;
            font-style: normal;
            margin: 20px;
            border-radius: 30px;
            background-color: rgb(248, 245, 245);
            box-shadow: rgba(14, 30, 37, 0.12) 0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;}
        h3{
            letter-spacing: 1px;
            font-size: 20px;
            line-break: loose;
        }
        hr{
            background-color: rgb(132, 132, 216);
            height: 4px;
        }
        li{
            list-style: none;
            text-align: center;
            color: white;
            font-size: 27px;
            padding-top: 50px;
        }
        img{
           border-radius: 8px;
           width: 300px;
           height: 500px;
           margin-left: 100px;       
        }
        #jj{
            text-align: center;
            text-transform: uppercase;
            color: white;
            padding: 80px;
            font-size: 26px;
            font-family: "Times New Roman", Times, serif;
          
        }
        #dt{
            position: absolute;
            top: 40px;
            left: 16px;
            width:200px;
            height:100px;
         
        }
        .css1{
  background-color:whitesmoke;
  font-size:30px;
  font-family: "Times New Roman", Times, serif;
  font-weight:bold;
  color:Balck;
  letter-sapcing:2px;
}
#fg{
    display:flex;
    justify-content: space-around;
    
}
    </style>

    <body>

        <header>

           
            <h3 id="jj"> providence college of engineering cse department</h3>
            <img id = "dt"src="https://providence.edu.in/wp-content/uploads/2021/06/CSE_White.png" >

            
            </header>
            <marquee class="css1"> IMPORTANT NOTICES</marquee>

<br> <br> 
        <div class="cardbox">
            <div class="studernt">
                <p>Faculty Notices</p>

                <%
                    dbconnection dbobj = new dbconnection();

                    JSONArray array = new JSONArray();
                    String qry = "SELECT *FROM `msg_faculty`,`faculty` WHERE `faculty`.`fid`=`msg_faculty`.`fid` and `msg_faculty`.`type`='Accepted'ORDER BY `msg_faculty`.`mfid` DESC";
                    System.out.println("qry=" + qry);
                    Iterator it = dbobj.getData(qry).iterator();
                    if (it.hasNext()) {

                        while (it.hasNext()) {
                            Vector v = (Vector) it.next();

                            //current date
                            Date date = new Date();
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                            String MYCURR = sdf.format(date);
                            //end

                            Date CURR = sdf.parse(MYCURR);
                            Date OLD = sdf.parse(v.get(5).toString());
                            System.out.println("Hey your Getting Date  Faculty:" + MYCURR + "OLD" + v.get(5).toString());

                           /// if (OLD.compareTo(CURR) > 0) {

                %>
                <div class="scard">
                    
                    <!--<h3>Email :<%=v.get(8).toString()%></h3>
                    <h3>Phone :<%=v.get(9).toString()%></h3><br>-->
                    <h3 id="fg">Notice</h3>
                    <br>
                    <hr><br>

                    <h3><%=v.get(2).toString()%></h3>
                    <%
                        String base = v.get(3).toString();
                        byte[] imageAsBytes = Base64.decode(base.getBytes());
                        System.out.println("Image --" + imageAsBytes);
                        //    setImageBitmap(BitmapFactory.decodeByteArray(imageAsBytes, 0, imageAsBytes.length) );
                        BufferedImage img = ImageIO.read(new ByteArrayInputStream(imageAsBytes));
                        System.out.println("Image Buddffer :" + img);

                    %>
                    
                    <img src="data:image/png;base64,<%=v.get(3).toString()%>" alt="Red dot"  width="100" height="100"/>
                    <h3>Notice By :<%=v.get(7).toString()%></h3>
                </div>

                <%
                            }
                      //  }
                        System.out.println(array);
                    } else {
                        System.out.println("else id");
                    }

                %>
            </div>
            <div class="faculty">
                <p>Student Notices</p>
                <%    String qrys = "SELECT * FROM `msg_student`,`student` WHERE `msg_student`.`sid`=`student`.`sid` and `msg_student`.`type`='Accepted' ORDER BY `msg_student`.`smid` DESC";
                    System.out.println("qry=" + qrys);

                    Iterator its = dbobj.getData(qrys).iterator();
                    if (its.hasNext()) {
                        while (its.hasNext()) {
                            Vector vs = (Vector) its.next();
                            Date date = new Date();
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                            String MYCURR = sdf.format(date);
                            //end

                            Date CURR = sdf.parse(MYCURR);
                            Date OLD = sdf.parse(vs.get(5).toString());
                            System.out.println("Hey your Getting Date  Faculty:" + MYCURR + "OLD" + vs.get(5).toString());

                        //    if (OLD.compareTo(CURR) > 0) {
                %>
                <div class="fcard">
                    
                    <!--<h3>Email :  <%=vs.get(8).toString()%></h3>
                    <h3>Phone :  <%=vs.get(9).toString()%></h3><br>-->

                    <h3 id="fg">Notice</h3>
                    <br>
                    <hr> <br>                <h3>
                        <%=vs.get(2).toString()%>
                    </h3>
                                    <img src="data:image/png;base64,<%=vs.get(3).toString()%>" alt="Red dot"  width="100" height="100"/>
                                    <h3>Notice By:   <%=vs.get(7).toString()%></h3>
                </div>
                <%
                       //  }
                        }
                        System.out.println(array);
                    } else {
                        System.out.println("else id");
                    }
                %>

            </div>
        </div>

    </body>
    <script>
        
        function generateHTML() {
  var picString = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
  var image = new Image();
  var src = "data:image/jpeg;base64," + picString;
  document.getElementById('img').src = src;
  document.body.appendChild(image);

}

generateHTML();
        </script>


</html>
