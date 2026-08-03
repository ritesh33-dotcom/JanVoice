<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="MyComplaints.aspx.cs" Inherits="JanVoice.Citizen.MyComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/mycomplaints.css" rel="stylesheet" />



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="complaints-page">

        <!-- Page Header -->

        <div class="page-header">

            <h1>My Complaints</h1>

            <p>
                Track all complaints submitted by you.
           
            </p>

        </div>

        <!-- Complaint List -->

        <div class="complaints-container">

            <asp:Repeater
                ID="rptComplaints"
                runat="server">

                <ItemTemplate>

                    <div class="complaint-card">

                        <!-- Image -->

                        <div class="card-image">

                            <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>'
                                alt="Complaint Image" />

                        </div>

                        <!-- Body -->

                        <div class="card-body">

                            <h2>

                                <%# Eval("Title") %>

                            </h2>

                            <div class="card-info">

                                <div>

                                    <strong>Category</strong>

                                    <span>

                                        <%# Eval("CategoryName") %>

                                    </span>

                                </div>

                                <div>

                                    <strong>Ward</strong>

                                    <span>

                                        <%# Eval("WardName") %>

                                    </span>

                                </div>

                            </div>

                            <div class="status-row">

                                <span class="status">

                                    <%# Eval("Status") %>

                                </span>

                                <span class="priority">

                                    <%# Eval("Priority") %>

                                </span>

                            </div>

                            <div class="date">

                                <%# Eval("CreatedDate","{0:dd MMM yyyy}") %>
                            </div>

                            <asp:Button
                                ID="btnView"
                                runat="server"
                                Text="View Details"
                                CssClass="view-btn"
                                CommandArgument='<%# Eval("ComplaintID") %>'
                                OnCommand="btnView_Command" />

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

            <div id="divNoComplaint"
                runat="server"
                class="empty-message"
                visible="false">

                <img src="../Images/no-image.png"
                    class="empty-image"
                    alt="No Complaints" />

                <h2>No Complaints Found</h2>

                <p>
                    You haven't reported any civic issues yet.
                </p>

            </div>

        </div>

    </div>
</asp:Content>
