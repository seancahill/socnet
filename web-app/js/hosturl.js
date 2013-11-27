function hosturl(method,env){
      var querystring = "";

      if ( env != "development") {
         querystring = "http://" + this.location.host + "/api/" + method;
      } else {
         querystring = "http://" + this.location.host + "/socnet/api/" + method;
      }
      return querystring
     }
