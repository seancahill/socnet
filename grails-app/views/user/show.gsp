
<%@ page import="socnet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body class="bodycenter">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span id="loginHeader"><g:loginControl /></span>
        </div>
        <div class="body">
            <h1>My Account Details</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                     
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.apiKey.label" default="Api Key" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "apiKey")}</td>
                            
                        </tr>
                       
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.login.label" default="Login" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "login")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.name.label" default="Name" /></td>                           
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "name")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.email.label" default="Email" /></td>                           
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.defaultContacts.label" default="Default Contacts" /></td>
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "defaultContacts")}</td>

                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${userInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                </g:form>
            </div>
             <g:link controller="userStop" action="list">Review Stop Words </g:link>
        </div>
       

    </body>
</html>
