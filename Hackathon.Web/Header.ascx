﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Hackathon.Web.Header" %>

<header>
    <div class="row">
        <div class="col-md-16 logo">
            <img src="/Content/logo-jquery.png" />
            <h2 class="title">Hackathon</h2>
        </div>
    </div>
    <!-- Nav tabs -->
    <ul class="nav nav-pills">
        <li><a href="/">Home</a></li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Framework<b class="caret"></b></a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownList">
                <li><a href="/AngularJS.aspx">AngularJS</a></li>
                <li><a href="/KnockoutJS.aspx">KnockoutJS</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grids<b class="caret"></b></a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownList">
                <li><a href="/SlickGridAngularJS.aspx">SlickGrid + AngularJS</a></li>
                <li><a href="/SlickGridKnockoutJS.aspx">SlickGrid + KnockoutJS</a></li>
                <li><a href="/SlickGridKnockoutJS.aspx">SlickGrid</a></li>
                <li><a href="/jqGridAngularJS.aspx">jqGrid + AngularJS</a></li>
                <li><a href="/jqGridKnockoutJS.aspx">jqGrid + KnockoutJS</a></li>
                <li><a href="/jqGridKnockoutJS.aspx">jqGrid</a></li>
            </ul>
        </li>
    </ul>
</header>
