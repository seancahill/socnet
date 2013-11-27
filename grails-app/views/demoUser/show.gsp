
<%@ page import="socnet.DemoUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'demoUser.label', default: 'DemoUser')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${demoUserInstance.id}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.bio.label" default="Bio" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "bio")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.country.label" default="Country" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "country")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.likes.label" default="Likes" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "likes")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.needs.label" default="Needs" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "needs")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="demoUser.town.label" default="Town" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demoUserInstance, field: "town")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${demoUserInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
