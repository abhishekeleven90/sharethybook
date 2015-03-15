<%@page import="com.sharethyapp.helper.WishList"%>
<%@page import="com.sharethyapp.helper.TransactionHistory"%>
<%@page import="com.sharethyapp.dbclasses.UserTable"%>
<%@page import="com.sharethyapp.helper.LoginHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.sharethyapp.helper.PhysicalBooks"%>
<article class="hero clearfix">
    <div class="col_100">
        <p style="color: #6aa12e">
            ${infoMsg}
        </p>
        <%if (LoginHelper.isLoggedIn(request)) {%>
        <h1>${user.entrynumber}</h1>
        <div class="img_floatright">
            <img width="60" height="80" src="profileimage.do?entrynumber=${user.entrynumber}"></img>
        </div>
        <%
            String sessionEntry = (String) request.getSession().getAttribute("entrynumber");
            UserTable usertable = (UserTable) request.getAttribute("user");
            String userEntry = usertable.getEntrynumber();
            if (!sessionEntry.equals(userEntry)) {
        %>
        <div class="img_floatright">
            <p><a href="#msg">Send a message</a></p>
        </div>
        <%}%>

        <p>

        <h3>Profile Details</h3>
        <table class="table">

            <tr>
            <td>First Name</td>
            <td>${user.firstname}</td>
            </tr>

            <tr>
            <td>Lastname </td> 
            <td>${user.lastname}</td>
            </tr>

            <tr>
            <td>Email-id</td> 
            <td>${user.emailId}</td>
            </tr>

            <tr>
            <td>TypeOfUser</td> 
            <td>${typeUser}</td>
            </tr>

            <tr>
            <td>Hosteler</td>
            <td>${user.isHosteler} </td>
            </tr>

            <tr>
            <td>HouseNo</td>
            <td>${user.houseNo}</td>
            </tr>


            <tr>
            <td>StreetNo/Hostel</td> 
            <td>${user.streetNo}</td>
            </tr>

            <tr>
            <td>City</td>
            <td>${user.city}</td>
            </tr>

            <tr>
            <td>State</td>
            <td>${user.state}</td>
            </tr>

            <tr>
            <td>Pincode</td>
            <td>${user.pincode}</td>
            </tr>

            <tr>
            <td>Number of unread messages</td>
            <td>${user.unreadMsgs}</td>
            </tr>

            <tr>
            <td>Number of books contributed</td> 
            <td>${user.booksContri}</td>
            </tr>

            <tr>
            <td>Number of books physically having</td>
            <td>${user.booksHave}</td>
            </tr>
        </table>
        <br/>

        <h3>Books Contributed</h3>

        <table class="table">

            <tr>
            <th>BookID</th>
            <th>ISBN</th>
            <th>HolderID</th>
            <th>HoldingDate</th>
            <th>Last Condition</th>
            <th>Revoke Book</th>
            </tr>

            <%
                List<PhysicalBooks> ownListTemp = (List<PhysicalBooks>) request.getAttribute("ownlist");
                if (ownListTemp != null)
                    for (PhysicalBooks tempbook : (List<PhysicalBooks>) request.getAttribute("ownlist")) {
                        pageContext.setAttribute("tempbook", tempbook);
            %>
            <tr>
            <td>${tempbook.bookidPhysical}</td>
            <td><a href="viewbook.do?isbn=${tempbook.isbn}">${tempbook.isbn}</a></td>
            <td><a href="profile.do?entrynumber=${tempbook.holderid}">${tempbook.holderid}</a></td>
            <td>${tempbook.holdingdate}</td>
            <td>${tempbook.lastCondition}</td>
            <td>Revoke</td>
            </tr>
            <%
                }
            %>

        </table>
        <br/>

        <h3>Books Having Physically</h3>

        <table class="table" width="100%">

            <tr>
            <th>BookID</th>
            <th>ISBN</th>
            <th>OwnerID</th>
            <th>HoldingDate</th>
            <th>Last Condition</th>
            </tr>

            <%
                List<PhysicalBooks> phyListTemp = (List<PhysicalBooks>) request.getAttribute("havinglist");
                if (phyListTemp != null)
                    for (PhysicalBooks tempbook : (List<PhysicalBooks>) request.getAttribute("havinglist")) {
                        pageContext.setAttribute("tempbook", tempbook);
            %>
            <tr>
            <td>${tempbook.bookidPhysical}</td>
            <td><a href="viewbook.do?isbn=${tempbook.isbn}">${tempbook.isbn}</a></td>
            <td><a href="profile.do?entrynumber=${tempbook.ownerid}">${tempbook.ownerid}</a></td>
            <td>${tempbook.holdingdate}</td>
            <td>${tempbook.lastCondition}</td>
            </tr>
            <%
                }
            %>



        </table>


        <h3>Books Requested By ${user.firstname}</h3>
        
         <table class="table" width="100%">

            <tr>
            <th>TransactionID</th>
            <th>Requested To</th>
            <th>BookID</th>
            <th>Start Date</th>
            <th>Last Update</th>
            <th>Status</th>
            <th>Condition</th>
            </tr>

            <%
                List<TransactionHistory> reqBooks = (List<TransactionHistory>) request.getAttribute("booksRequested");
                if (reqBooks != null)
                    for (TransactionHistory tempbook : reqBooks) {
                        pageContext.setAttribute("tempbook", tempbook);
            %>
            <tr>
            <td>${tempbook.getTransactionID()}</td>
            <td>${tempbook.getToID()}</td>
            <td>${tempbook.getBookID()}</td>
            <td>${tempbook.getTransStartDate()}</td>
            <td>${tempbook.getLastUpdate()}</td>
             <td>${tempbook.getStatus()}</td>
            <td>${tempbook.getBookCondition()}</td>
            </tr>
            <%
                }
            %>



        </table>
        

        
        <h3>Books Requested From ${user.firstname}</h3>
        
        <table class="table" width="100%">

            <tr>
            <th>TransactionID</th>
            <th>Requested To</th>
            <th>BookID</th>
            <th>Start Date</th>
            <th>Last Update</th>
            <th>Status</th>
            <th>Condition</th>
            </tr>

            <%
                List<TransactionHistory> reqBooksPending = (List<TransactionHistory>) request.getAttribute("booksReqPending");
                if (reqBooksPending != null)
                    for (TransactionHistory tempbook : reqBooksPending) {
                        pageContext.setAttribute("tempbook", tempbook);
            %>
            <tr>
            <td>${tempbook.getTransactionID()}</td>
            <td>${tempbook.getFromID()}</td>
            <td>${tempbook.getBookID()}</td>
            <td>${tempbook.getTransStartDate()}</td>
            <td>${tempbook.getLastUpdate()}</td>
             <td>${tempbook.getStatus()}</td>
            <td>${tempbook.getBookCondition()}</td>
            </tr>
            <%
                }
            %>



        </table>
        <h3>${user.firstname}'s Wish-list!</h3>
        
        <table class="table" width="100%">

            <tr>
            <th>ISBN</th>
            <th>Title</th>
            <th>Date</th>
            </tr>

            <%
                List<WishList> booksWished = (List<WishList>) request.getAttribute("booksWished");
                if (booksWished != null)
                    for (WishList tempbook : booksWished) {
                        pageContext.setAttribute("tempbook", tempbook);
            %>
            <tr>
            <td>${tempbook.getIsbn()}</td>
            <td>${tempbook.getTitle()}</td>
            <td>${tempbook.getDate()}</td>
            </tr>
            <%
                }
            %>



        </table>

        <%
            if (!sessionEntry.equals(userEntry)) {
        %>
        <a name="msg"></a>
        <h3>Say Hi to ${user.firstname}</h3>

        <!-- Form for message here!! Phew -->
        <form action="message.do" method="post" class="form">

            <input type="hidden" name="fromid" id="fromid" value="${sessionScope.entrynumber}" />
            <input type="hidden" name="toid" id="toid" value="${user.entrynumber}"/>

            <div class="col_100">

                <table class="table">
                    <tr></tr>

                    <tr>
                    <td><label for="msg">Type Message Here</label><br/></td>
                    <td>
                        <textarea name="msg" id="msg" rows="4" cols="50" value=""></textarea>               
                    </td>                
                    </tr>

                </table><br/>




            </div>
            <div>
                <button type="submit" class="button" onclick="submit">Submit</button>
            </div>

            <br/>
            <p class="col_50" style="color: red">
                ${requestScope.error}
            </p>
            <br/>
        </form>

        <%} else { %>

        <h3>Settings and features</h3>
        <div>
            <a href="addbook.jsp">Contribute a book</a> <br/>
            <a href="beforeedit.do?entrynumber=${user.entrynumber}">Edit Profile Details</a> <br/>
            <a href="changePassword.jsp">Change Password </a> <br/>
            <a href="editProfileImage.jsp">Edit Profile Image</a> <br/>
            <a href="allmsgsview.do">View messages</a> <br/>
        </div>
        <%}%>
    </div>
    <%} else {%>
    <p class="col_50" style="color: #444">
        Not logged in. Please login.
    </p>
    <br/>
    <%}%>

</article>

<br/>
<br/>