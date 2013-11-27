<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="socnet.DemoUser" %>
<html>
  <head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'demoUser.label', default: 'DemoUser')}" />
    <g:javascript library="hosturl" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>

  <script type="text/JavaScript">

    
  
  $(document).ready(function () {

          // Hide the "view"
          
           $("#keywords").click(function (e) {

                  $('.lielem').remove();
                  var querystring = hosturl("stemToKeywords",'${GrailsUtil.environment}');
                  $('body').css({'cursor': 'progress'});
                  $('#keywords').css({'cursor': 'progress'});
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239";
                  var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"text":"${demoUserInstance.bio}","type":"bio"};

                  $.ajax({
                      type: "POST",
                      url: querystring ,
                      data: data,
                      dataType: "json",
                      success: function (response) {
                          var mess = response;
                          for (var i=0; i<mess.length; i++) {
                              
                              var elem = "#keywordlist";
                              var elem = $(elem).show();
                              elem.append("<li class='lielem'>"+mess[i]+'</li>');
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                              $('body').css({'cursor': 'default'});
                              $('#keywords').css({'cursor': 'default'});
                              }
                  });
           });
           $("#freekeywords").click(function (e) {
                  $('.lifreeelem').remove();
                  var querystring = hosturl("stemToKeywords",'${GrailsUtil.environment}');
                  $('body').css({'cursor': 'progress'});
                  $('#freekeywords').css({'cursor': 'progress'});
                  var text = document.getElementById('freetext').value;
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239";
                  var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"text":text,"type":"bio"};

                  $.ajax({
                      type: "POST",
                      url: querystring ,
                      data: data,
                      dataType: "json",
                      success: function (response) {
                          var mess = response;
                          for (var i=0; i<mess.length; i++) {

                              var elem = "#freekeywordlist";
                              var elem = $(elem).show();
                              elem.append("<li class='lifreeelem'>"+mess[i]+'</li>');
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                              $('body').css({'cursor': 'default'});
                              $('#freekeywords').css({'cursor': 'default'});
                              }
                  });
           });
  });
  </script>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" controller="api" action="demo"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span id="loginHeader"> <g:loginControl /></span>
  </div>
  <div class="body">
    <h1>Text To Keyword</h1>
    <br/>
    <div id="demomaindiv" class="fleft">
      <div class="dialog fleft">
        <table style="width: 20em;">
          <tbody>
            <tr class="prop">
              <td valign="top" class="name"><g:message code="demoUser.bio.label" default="Bio" /></td>
          <td valign="top" class="value" id="highlight">${demoUserInstance.bio}</td>
          </tr>
          </tbody>
        </table>
      </div>
      <div class="fleft">
        <ul id="keywordlist" class="hidden">

        </ul>
      </div>
      <div class="clear"></div>
      <br/>
      <button id="keywords">Create Keywords</button>
    </div>
  </div>
<g:render template="/shared/sidebar"/>
<div class="clear"></div>

<div class="shifty fleft">
  <h2>Enter Text</h2>
  <br/>
  <div class="fleft">
  <div class="panelTop"></div>
  <div class="panelBody">
  <textarea id="freetext" cols="40"  rows="40">

  </textarea>
  </div>
  <div class="panelBtm"></div>
  </div>
  <div class="fleft">
    <ul id="freekeywordlist" class="hidden">

    </ul>
  </div>
  <div class="clear"></div>
  <br/>
  <button id="freekeywords">Create Keywords</button>
</div>

</body>

</html>
