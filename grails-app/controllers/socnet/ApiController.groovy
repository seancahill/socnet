package socnet
import grails.converters.deep.*
import grails.converters.*
import socnet.Application
import socnet.UserIdentity
import socnet.Keyword
import edu.ncirl.*
import grails.util.GrailsUtil
import grails.web.JSONBuilder
import edu.ncirl.exceptions.*


class ApiController {
    def profileService
    static allowedMethods = [stemToKeywords: "POST",
        profile: "POST",profile: 'GET', match: "POST",
        profileFormatted: "POST",profileFormatted: 'GET',
        show: "GET", delete: "POST", collaborate: "POST",
        compare: "POST",likes: "POST"]

    def index = {

    }

    def userTest = {
        if (!Application.count())
        { render "none"}
        else
        {
            def user = UserIdentity.findByIdentity("123456")
            if (!user)
            render "none"
            else
            render user.profile
        }
    }
    def show = {
        def apps = Application.list()
        def passed = params
        render passed as JSON
    }

    def delete = {
        if (profileService.registeredUser(params.api)) {
            try {
                if (!params.user) {
                    throw MissingParameterException("Missing Or Invalid Parameter Passed")
                }
                def message = profileService.deleteUser(params)
                if ( message == "success") {
                    log.info("deleted user")
                    response.status = 200 //Success
                    render "successfully deleted user ${params.user}"
                }
                else {
                    response.status = 502 //not Success
                    render "problems deleting user " + message
                }
            }
            catch (MissingParameterException e) {
                response.status = 502 //not Success
                render "problems deleting users profile, missing parameter"
            }
            catch (e) {
                response.status = 501 //not Success
                render "problems deleting users profile"
            }

        }
        else{
            response.status = 400 //Bad Request
            render "error: GET request must include valid api-key Example: /socnet/api/<api-key>"
        }

    }
    def returnMessage(String mess, params)
    {
        if (params.callback) {
            def message = ['message': mess]
            return "${params.callback}(${message as grails.converters.JSON})"
        }
        else
        {return mess}
    }
    def profile = {
        // POST method from api call to index a users profile
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.profile - a string of the users profile
        // params.type - type of profile e.g. bio,needs,likes
        // params.user - unique identifier identifying the user
        if (profileService.registeredUser(params)) {
            SStack stemmed = prepareFreeText(params.profile,params.api)
            try {
                profileService.indexUser(params,stemmed)
                response.status = 200 //Success
                render returnMessage("successfully indexed users profile",params)
            }
            catch (e) {
                response.status = 500 //not Success
                render returnMessage("problems indexing users profile",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: POST request must include valid api-key ",params)
        }
    }
    def stemToKeywords = {
        // POST method from api call to index a users profile
        // useage: require
        // params.text - text to reduce to keywords

        def user = User.findByName("demo")
        SStack stemmed = prepareFreeText(params.text,user.apiKey)
        render stemmed as JSON
    }

    def profileFormatted = {
        // POST method from api call to index a users profile
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.profile - a string of the users profile
        // params.type - type of profile e.g. bio,needs,likes
        // params.user - unique identifier identifying the user
        if (profileService.registeredUser(params)) {
            if (!params.user) {
                throw MissingParameterException("Missing Or Invalid Parameter Passed")
                return
            }
            SStack unstemmed = params.likes.split(',') // just in case convert to lower case
            SStack lowered = unstemmed.toLower()
            String stemmed = lowered.join(',')
            try {
                profileService.indexUserLikes(params,stemmed)
                response.status = 200 //Success
                render returnMessage("successfully indexed users profile",params)
            }
            catch (e) {
                response.status = 500 //not Success
                render returnMessage("problems indexing users profile",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: POST request must include valid api-key",params)
        }
    }
    def compare = {
        // POST method from api call to index a users profile
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.user - unique identifier identifying the user
        // params.compareUser - unique identifier identifying the user

        if (profileService.registeredUser(params)) {
            try {
                if (params.needs) {
                    SStack stemmed = prepareFreeText(params.needs,params.api)
                    params.needs = stemmed.toStoreString()
                }
                SStack compare = profileService.compareUsers(params)
                response.status = 200 //Success
                //only want to return unique matches
                Set<String> uniqueSet = new HashSet<String>(compare);
                def uf = uniqueSet as grails.converters.JSON
                if (params.callback){ //jsonp with callback
                    render "${params.callback}(${uf})"
                }
                else{
                    render uf
                }
            }
            catch (e) {
                response.status = 500 //not Success
                render returnMessage("problems comparing users ",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: POST request must include valid api-key ",params)
        }
    }
    def collaborate = {
        // POST method from api call to index a users profile
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.needs - a string of the users profile
        // params.type - type of profile e.g. bio,needs,likes
        // params.user - unique identifier identifying the user
        SStack stemmed
        if (profileService.registeredUser(params)) {
            if (!params.needs) {
                throw MissingParameterException("Missing Or Invalid Parameter Passed")
            }
            else {
                stemmed = prepareFreeText(params.needs,params.api)
            }
            try {
                Map returnMap = profileService.needsToProfileMethod(params,stemmed)
                List matches = returnMap["users"]
                def message = returnMap["message"]
                if ( message == "success") {
                    def frequencyMap = sortFrequencyMatches(matches)
                    def uf = userFrequencyMapToArray(frequencyMap) as grails.converters.JSON
                    response.status = 200 //Success
                    if (params.callback){ //jsonp with callback
                        render "${params.callback}(${uf})"
                    }
                    else{
                        render uf
                    }
                }
                else {
                    response.status = 502 //not Success
                    render returnMessage("problems matching needs to profile ${message}",params)
                }
            }
            catch (e) {
                response.status = 500 //not Success
                render returnMessage("problems matching needs to users profile",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: POST request must include valid api-key ",params)
        }
    }
    def likes = {
        // POST method from api call to index a users profile
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.needs - a string of the users profile
        // params.type - type of profile e.g. bio,needs,likes
        // params.user - unique identifier identifying the user
        SStack stemmed
        if (profileService.registeredUser(params)) {
            if (!params.type) {
                throw MissingParameterException("Missing Or Invalid Parameter Passed")
            }
            try {
                Map returnMap = profileService.likesToLikesMethod(params)
                List matches = returnMap["users"]
                def message = returnMap["message"]
                if ( message == "success") {
                    def frequencyMap = sortFrequencyMatches(matches)
                    def uf = userFrequencyMapToArray(frequencyMap) as grails.converters.JSON
                    response.status = 200 //Success
                    if (params.callback){ //jsonp with callback
                        render "${params.callback}(${uf})"
                    }
                    else{
                        render uf
                    }
                }
                else {
                    response.status = 502 //not Success
                    render returnMessage("problems matching needs to profile ${message}",params)
                }
            }
            catch (e) {
                response.status = 500 //not Success
                render returnMessage("problems matching needs to users profile",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: POST request must include valid api-key ",params)
        }
    }

    def match = {
        // GET method from api call to find user matches
        // useage: require
        // params.api - the applications api key
        // params.name - the name of the application
        // params.type - type of profile e.g. bio,needs,likes to match
        // params.user - unique identifier identifying the user
        if (profileService.registeredUser(params)) {

            try {
                if (!params.user) {
                    throw MissingParameterException("Missing Or Invalid Parameter Passed")
                }
                Map returnMap = profileService.matchMethod(params)
                List matches = returnMap["users"]
                def message = returnMap["message"]
                if ( message == "success") {
                    //sort the list by frequency
                    def frequencyMap = sortFrequencyMatches(matches)
                    def uf = userFrequencyMapToArray(frequencyMap) as grails.converters.JSON
                    response.status = 200 //Success
                    if (params.callback){ //jsonp with callback
                        render "${params.callback}(${uf})"
                    }
                    else{
                        render uf
                    }
                }
                else {
                    response.status = 502 //not Success
                    render returnMessage("problems matching ${message}",params)
                }
            }
            catch (MissingParameterException e) {
                response.status = 502 //not Success
                render returnMessage("problems matching users profie, missing parameter",params)
            }
            catch (e) {
                response.status = 501 //not Success
                render returnMessage("problems matching users profile",params)
            }
        }
        else{
            response.status = 400 //Bad Request
            render returnMessage("error: GET request must include valid api-key ",params)
        }
    }

    def keywordsJSON = {
        render Keywords.list() as JSON

    }

    def prepareFreeText(def textToStem,def api) {
        def profile = URLDecoder.decode(textToStem)
        //clean data
        SStack stack1 = Parser.StripSearch(profile)
        //use SStack so that we can reform stack into single string
        
        String stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
        SStack stemmed = Stemmer.StemText(stopped)
        return stemmed
    }
    def sortFrequencyMatches(def matches) {
        def uniqueSet = matches as Set
        //create a frequency map of the user matches returned
        def frequencyMap = [:]
        for (elem in uniqueSet) {
            frequencyMap.put(elem,matches.count(elem))
        }
        //sort the map by frequency
        frequencyMap = frequencyMap.sort { a,b -> b.value <=> a.value }
        return frequencyMap
    }
    def userFrequencyMapToArray(map){
        def bars = new ArrayList()
      
        map.each { k,v ->
            def barMap = new HashMap()
            barMap.put("user", k)
            barMap.put("frequency", v)
            bars.add(barMap)
        }
        return bars
    }

    def demo = {
        render(view : "demo")
    }
}
