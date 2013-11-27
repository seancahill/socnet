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
  var howmatch = "";
  function setMatching(what) {
    howmatch = what
  }
  /*
   * This is the function that actually highlights a text string by
   * adding HTML tags before and after all occurrences of the search
   * term. You can pass your own tags if you'd like, or if the
   * highlightStartTag or highlightEndTag parameters are omitted or
   * are empty strings then the default <font> tags will be used.
   */
  function doHighlight(bodyText, searchTerm, highlightStartTag, highlightEndTag)
  {
    // the highlightStartTag and highlightEndTag parameters are optional
    if ((!highlightStartTag) || (!highlightEndTag)) {
      highlightStartTag = "<font class='fontcc' style='color:blue; background-color:pink;'>";
      highlightEndTag = "</font>";
    }

    // find all occurences of the search term in the given text,
    // and add some "highlight" tags to them (we're not using a
    // regular expression search, because we want to filter out
    // matches that occur within HTML tags and script blocks, so
    // we have to do a little extra validation)
    var newText = "";
    var i = -1;
    var lcSearchTerm = searchTerm.toLowerCase();
    var lcBodyText = bodyText.toLowerCase();

    while (bodyText.length > 0) {
      i = lcBodyText.indexOf(lcSearchTerm, i+1);
      if (i < 0) {
        newText += bodyText;
        bodyText = "";
      } else {
        // skip anything inside an HTML tag
        if (bodyText.lastIndexOf(">", i) >= bodyText.lastIndexOf("<", i)) {
          // skip anything inside a <script> block
          if (lcBodyText.lastIndexOf("/script>", i) >= lcBodyText.lastIndexOf("<script", i)) {
            newText += bodyText.substring(0, i) + highlightStartTag + bodyText.substr(i, searchTerm.length) + highlightEndTag;
            bodyText = bodyText.substr(i + searchTerm.length);
            lcBodyText = bodyText.toLowerCase();
            i = -1;
          }
        }
      }
    }

    return newText;
  }


  /*
   * This is sort of a wrapper function to the doHighlight function.
   * It takes the searchText that you pass, optionally splits it into
   * separate words, and transforms the text on the current web page.
   * Only the "searchText" parameter is required; all other parameters
   * are optional and can be omitted.
   */
  function highlightSearchTerms(searchText, element, treatAsPhrase, warnOnFailure, highlightStartTag, highlightEndTag)
  {
    // if the treatAsPhrase parameter is true, then we should search for
    // the entire phrase that was entered; otherwise, we will split the
    // search string so that each word is searched for and highlighted
    // individually
    if (treatAsPhrase) {
      searchArray = [searchText];
    } else {
      searchArray = searchText.split(" ");
    }

    if (!document.body || typeof(document.getElementById(element).innerHTML) == "undefined") {
      if (warnOnFailure) {
        alert("Sorry, for some reason the text of this page is unavailable. Searching will not work.");
      }
      return false;
    }

    var bodyText = document.getElementById(element).innerHTML;
    for (var i = 0; i < searchArray.length; i++) {
      bodyText = doHighlight(bodyText, searchArray[i], highlightStartTag, highlightEndTag);
    }

    document.getElementById(element).innerHTML = bodyText;
    return true;
  }


  /*
   * This displays a dialog box that allows a user to enter their own
   * search terms to highlight on the page, and then passes the search
   * text or phrase to the highlightSearchTerms function. All parameters
   * are optional.
   */
  function searchPrompt(defaultText, treatAsPhrase, textColor, bgColor)
  {
    // This function prompts the user for any words that should
    // be highlighted on this web page
    if (!defaultText) {
      defaultText = "";
    }

    // we can optionally use our own highlight tag values
    if ((!textColor) || (!bgColor)) {
      highlightStartTag = "";
      highlightEndTag = "";
    } else {
      highlightStartTag = "<font style='color:" + textColor + "; background-color:" + bgColor + ";'>";
      highlightEndTag = "</font>";
    }

    if (treatAsPhrase) {
      promptText = "Please enter the phrase you'd like to search for:";
    } else {
      promptText = "Please enter the words you'd like to search for, separated by spaces:";
    }

    searchText = prompt(promptText, defaultText);

    if (!searchText)  {
      alert("No search terms were entered. Exiting function.");
      return false;
    }

    return highlightSearchTerms(searchText, element, treatAsPhrase, true, highlightStartTag, highlightEndTag);
  }
 
  $(document).ready(function () {

          // Hide the "view"
          //
          $('div.view').hide();
          //
          // Watch for clicks on the "slide" link.
          $('span.slide').click(function()
          { // When clicked, toggle the "view" div.
            var elem = this.id.split('-');
            var divtoexp = 'div'+'#show'+elem[1];
            if (this.innerHTML == '+') {
              this.innerHTML = '-';
              $('span.slide').css({'font-size':'12px'});
              $('span.slide').css({'padding-left':'2px'});
              $('span.slide').css({'padding-right':'2px'});
            }
            else {
              this.innerHTML = '+'
                $('span.slide').css({'font-size':'11px'});
                $('span.slide').css({'padding-left':'0px'});
                $('span.slide').css({'padding-right':'0px'});
            }
            $(divtoexp).slideToggle(400);
            if (howmatch == 'match')
              { $('#compProfile'+elem[1]).show();
                $('#compNeeds'+elem[1]).hide();
                $('#compLikes'+elem[1]).hide();}
            if (howmatch == 'collaborate')
              { $('#compProfile'+elem[1]).hide();
                $('#compNeeds'+elem[1]).show();
                $('#compLikes'+elem[1]).hide();}
            if (howmatch == 'likes')
              { $('#compProfile'+elem[1]).hide();
                $('#compNeeds'+elem[1]).hide();
                $('#compLikes'+elem[1]).show();}

        });
              
        $("div#userlist ul li button").click(function (e) {
                  var name = this.name;
                  var querystring = "";
                  var data = {};
                  var high = "";
                  var cross = "";
                  var elemBut =   "#compProfile"+name;
                  $('body').css({'cursor': 'progress'});
                  $(elemBut).css({'cursor': 'progress'});
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239"
                  if ( howmatch == 'match') {
                    cross = "highlight";
                    high = "highlight";
                    querystring = hosturl('compare','${GrailsUtil.environment}');
                    var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"user":"${demoUserInstance.identity}","compareUser":name,"type":"bio"};
                    }

                  if ( howmatch == 'collaborate') {
                    high = "highlightneeds";
                    cross = "highlight";
                    querystring = hosturl('compare','${GrailsUtil.environment}');
                    var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"needs":"${demoUserInstance.needs}","user":"${demoUserInstance.identity}","compareUser":name,"type":"needs"};
                    }

                  if ( howmatch == 'likes') {
                    cross = "highlightlikes";
                    high = "highlightlikes";
                    querystring = hosturl('compare','${GrailsUtil.environment}');
                    var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"user":"${demoUserInstance.identity}","compareUser":name,"type":"likes"};
         }

                  $.ajax({
                      type: "POST",url: querystring ,data: data,dataType: "json",
                      success: function (response) {
                          var mess = response;
                          var usercompare = cross + name;
                          for (var i=0; i<mess.length; i++) {
                              highlightSearchTerms(mess[i],high);
                              highlightSearchTerms(mess[i],usercompare);
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                                $('body').css({'cursor': 'default'});
                                $(elemBut).css({'cursor': 'default'});
                              }
                  });
         });
         
         
          $("#collaborate").click(function (e) {
                  setMatching('collaborate');
                  $('.fontcc').css({'color':'black','background-color':'white'});
                  var querystring = hosturl('collaborate','${GrailsUtil.environment}');
                  $('body').css({'cursor': 'progress'});
                  $('#collaborate').css({'cursor': 'progress'});
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239"
                  
                  var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"needs":"${demoUserInstance.needs}","type":"bio"};
                  
                  $('#showhead').hide();
                  $('div#userlist ul li').hide();
                         
                  $.ajax({
                      type: "POST",
                      url: querystring ,
                      data: data,
                      dataType: "json",
                      success: function (response) {
                          var mess = response;
                          if (mess.length > 0) {
                            $('#showhead').show();
                          }
                          else {
                            $('#showhead').hide();
                          }
                          for (var i=0; i<mess.length; i++) {
                              var user = mess[i].user;
                              var elem = "#"+user;
                              var elem = $(elem).show();
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                                  $('body').css({'cursor': 'default'});
                                  $('#collaborate').css({'cursor': 'default'});
                              }
                  });
          });
          $("#likes").click(function (e) {
                  setMatching('likes');
                  $('.fontcc').css({'color':'black','background-color':'white'});
                  var querystring = hosturl('likes','${GrailsUtil.environment}');
                  $('body').css({'cursor': 'progress'});
                  $('#likes').css({'cursor': 'progress'});
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239"
                  
                  var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"user":"${demoUserInstance.identity}","type":"likes"};

                  $('#showhead').hide();
                  $('div#userlist ul li').hide();

                  $.ajax({
                      type: "POST",
                      url: querystring ,
                      data: data,
                      dataType: "json",
                      success: function (response) {
                          var mess = response;
                          if (mess.length > 0) {
                            $('#showhead').show();
                          }
                          else {
                            $('#showhead').hide();
                          }
                          for (var i=0; i<mess.length; i++) {
                              var user = mess[i].user;
                              var elem = "#"+user;
                              var elem = $(elem).show();
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                              $('body').css({'cursor': 'default'});
                              $('#likes').css({'cursor': 'default'});
                              }
                  });
                  });
           $("#contact").click(function (e) {
                  $('.fontcc').css({'color':'black','background-color':'white'});
                  setMatching('match');
                  var querystring = hosturl('match','${GrailsUtil.environment}');
                  $('body').css({'cursor': 'progress'});
                  $('#contact').css({'cursor': 'progress'});
                  var api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239";

                  var data = { "country":"${demoUserInstance.country}","state":"${demoUserInstance.state}","town":"${demoUserInstance.town}","name": "demo", "api": api,"user":"${demoUserInstance.identity}","type":"bio"};

                  $('#showhead').hide();
                  $('div#userlist ul li').hide();

                  $.ajax({
                      type: "POST",
                      url: querystring ,
                      data: data,
                      dataType: "json",
                      success: function (response) {
                          var mess = response;
                          if (mess.length > 0) {
                            $('#showhead').show();
                          }
                          else {
                            $('#showhead').hide();
                          }
                          for (var i=0; i<mess.length; i++) {
                              var user = mess[i].user;
                              var elem = "#"+user;
                              var elem = $(elem).show();
                          }
                      },
                      error: function (XMLHttpRequest, textStatus, errorThrown) {
                      // handle error
                      var i=0;
                      },
                      complete: function() {
                              $('body').css({'cursor': 'default'});
                              $('#contact').css({'cursor': 'default'});
                              $('#compProfile').show();
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
    <div id="maindiv" class="fleft">
      <div class="dialog">
        <table>
          <tbody>
            <tr class="prop">
              <td valign="top" class="name"><img width="42px" height="42px" style="padding-right: 1em;" class="fleft" src="${resource(dir:'images',file:'6.jpg')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
              <span class="pushright">${demoUserInstance.name}</span></td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">Location</td>
              <td valign="top" class="value">${demoUserInstance.country}, ${demoUserInstance.state}, ${demoUserInstance.town}</td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name"><g:message code="demoUser.bio.label" default="Bio" /></td>
              <td valign="top" class="value" id="highlight">${demoUserInstance.bio}</td>
            </tr>

            <tr class="prop">
             <td valign="top" class="name"><g:message code="demoUser.likes.label" default="Likes" /></td>
             <td valign="top" class="value" id="highlightlikes">${demoUserInstance.likes}</td>
            </tr>

          <tr class="prop">
            <td valign="top" class="name" ><g:message code="demoUser.needs.label" default="Needs" /></td>
            <td valign="top" class="value" id="highlightneeds">${demoUserInstance.needs}</td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="clear"></div><br/>
      <h2>Find Matches</h2><br/>
      <p class="fleft ptop">> find potential contacts with similar profile </p>
      <img class="fleft cimg" id="contact" src="${resource(dir:'images',file:'go_icon.jpg')}" alt="go icon"/>
      <p class="fleft ptop">> find potential contacts based on my needs     </p>
      <img class="fleft cimg" id="collaborate" src="${resource(dir:'images',file:'go_icon.jpg')}" alt="go icon"/>
      <p class="fleft ptop">> find potential contacts based on my likes     </p>
      <img class="fleft cimg" id="likes" src="${resource(dir:'images',file:'go_icon.jpg')}" alt="go icon"/>

    </div>

    <div id ="userlist" class="fleft">
      <h2 id="showhead" class="hidden">Matches Found</h2>
      <ul>

        <g:each in="${demoUserInstanceList}" status="i" var="demoUserInstance">
          <li class="hidden" id="${demoUserInstance.identity}">
            <img width="32px" height="32px" style="padding-right: 1em;" class="fleft" src="../images/${i}.jpg" alt="${message(code:'spinner.alt',default:'Loading...')}" />
            <p>${demoUserInstance.name}</p>
            <p>${demoUserInstance.country}, ${demoUserInstance.state}, ${demoUserInstance.town}</p>
            <span id="click-${demoUserInstance.identity}"  class="slide">+</span><span class="heading">  Profile</span>
            <div id="show${demoUserInstance.identity}" class="view">
              <g:message code="demoUser.bio.label" default="Bio" />
              <p  id="highlight${demoUserInstance.identity}">${demoUserInstance.bio}</p>

              <g:message code="demoUser.likes.label" default="Likes" />
              <p id="highlightlikes${demoUserInstance.identity}"">${demoUserInstance.likes}</p>

              <g:message code="demoUser.needs.label" default="Needs" />
              <p id="highlightneeds${demoUserInstance.identity}">${demoUserInstance.needs}</p>
              <button id="compProfile${demoUserInstance.identity}" class="pattern" name="${demoUserInstance.identity}">Compare</button>
              <button id="compNeeds${demoUserInstance.identity}" class="pattern" name="${demoUserInstance.identity}">Compare</button>
              <button id="compLikes${demoUserInstance.identity}" class="pattern" name="${demoUserInstance.identity}">Compare</button>
            </div>
          </li>
        </g:each>

      </ul>

    </div>
    <g:render template="/shared/sidebar"/>
  </div>

</body>

</html>
