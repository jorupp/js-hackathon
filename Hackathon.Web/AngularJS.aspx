<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <p>{{message}}</p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/angular-1.2.6.min.js"></script>
<script type="text/javascript">
    function App($scope) {
        // put your angular-using code here.  Angular knows to call this because the function name matches the ng-controller attribute above
        $scope.message = "Hello from Angular";
    }
</script>
</asp:Content>

