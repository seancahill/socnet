<html>
  <head>
    <title>Welcome to the Profiler API</title>
    <meta name="layout" content="main" />
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="js/jquery-1.3.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.betterTooltip.js"></script>

    <style type="text/css" media="screen">

      #nav {
        margin-top:20px;
        margin-left:30px;
        width:228px;
        float:left;

      }
      .homePagePanel * {
        margin:0px;
      }
      .homePagePanel .panelBody ul {
        list-style-type:none;
        margin-bottom:10px;
      }
      .homePagePanel .panelBody h1 {
        text-transform:uppercase;
        font-size:1.1em;
        margin-bottom:10px;
      }
      .homePagePanel .panelBody {
        background: url(images/leftnav_midstretch.png) repeat-y top;
        margin:0px;
        padding:15px;
      }
      .homePagePanel .panelBtm {
        background: url(images/leftnav_btm.png) no-repeat top;
        height:20px;
        margin:0px;
      }

      .homePagePanel .panelTop {
        background: url(images/leftnav_top.png) no-repeat top;
        height:11px;
        margin:0px;
      }
      h2 {
        margin-top:15px;
        margin-bottom:15px;
        font-size:1.2em;
      }
      #pageBody {
        padding-top: 1em;
        margin-left:10px;
        margin-right:20px;
        width: 50%;
      }
      #paramain {
        padding-top: 1em;
        font: 12px/14px verdana, arial, helvetica, sans-serif;
      }
      fleft { float: left;}
    </style>
    <script type="text/javascript">
		$(document).ready(function(){
			$('.tTip').betterTooltip({speed: 150, delay: 300});
		})
    </script>
  </head>
  <body >
    <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span id="loginHeader"> <g:loginControl /></span>
  </div>
    <div id="nav">
      <div class="homePagePanel">
        <div class="panelTop"></div>
        <div class="panelBody">
          <h1>Free Membership</h1>

          <p>With this type of membership you get to index up to
            100 members of your social network. The data is stored
            on a shared database server.</p>

        </div>
        <div class="panelBtm"></div>
        <div class="panelTop"></div>
        <div class="panelBody">
          <h1>Profiler Lite</h1>

          <p>With this type of membership you get to index up to
            10,000 members of your social network. The data is stored
            on a shared database server.</p>
          <div class="tTip" title="We are currently in beta mode. Stop by for updates">Contact us for pricing</div>


        </div>
        <div class="panelBtm"></div>
        <div class="panelTop"></div>
        <div class="panelBody">
          <h1>Profiler Professional</h1>

          <p>With this type of membership you get to index up to
            any number of members of your social network. The data is stored
            on a dedicated database server.</p>
          <div class="tTip" title="We are currently in beta mode. Stop by for updates">Contact us for pricing</div>

        </div>
        <div class="panelBtm"></div>
      </div>

    </div>
    <div id="pageBody" class="fleft">
      <h1>Welcome to the Profiler API application</h1>
      <p id="paramain">The Profiler API application allows registered users to index their social network members. The
        application will take the profile of a member of your social network and index them
        based on their stored profile. This makes your social network searchable based on
        keywords within a members profile.</p>
      <img class="fright" id="likes" src="${resource(dir:'images',file:'profile1.PNG')}" alt="profile image"/>
      <p id="paramain">We provide all the necessary <a href="${createLink(uri: '/demoUser/apiusage')}">apis</a> for you to index your members profile.
      We also provide apis to perform matching to enable your users contact other members of your network based on criteria
      such as profile biography, their needs/wants or their interests and hobbies.</p>
       <p id="paramain">All indexed data is held on our dedicated databases. We do not store any personal
       information about your members. All that is required is that your user is uniquely identified via an
       id.</p>
       <p id="paramain">To see how the application works view our <a href="${createLink(uri: '/api/demo')}">demo</a>. To see a list of available
       api's view our detailed usage information</p>


    </div>
  <g:render template="/shared/sidebar"/>
</body>
</html>
