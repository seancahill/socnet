package socnet
import com.eaio.stringsearch.*
import edu.ncirl.PatternMatcher
import edu.ncirl.SStack
import edu.ncirl.Stopper
import edu.ncirl.exceptions.NotFoundException
import edu.ncirl.exceptions.MissingParameterException


class ProfileService {
    static transactional = false
    
    def allStops(def api) {
        HashSet swords = Stopper.StopWordList(); //static file of stop words
        def words = UserStop.findByApiKey(api) //add application exceptions
        for (word in words) {
            swords.add(word.word)
        }
        return swords
    }

    def registeredUser(def params) {
        def user = null
        if (params.api) {
            if (params.name == 'mingle') {
                return true }
            user = User.findByApiKey(params.api)
        }
        return user
    }

    def stopList(def api) {
        return UserStop.findByApiKey(api)
    }

    def getApplication(def api) throws NotFoundException {
        def application = Application.findByApi(api)

        if (!application) {
            throw new NotFoundException("cannot find application with given api key")
        }
        application
    }

    def getUser(def id,api) throws NotFoundException {
        def user = UserIdentity.findByIdentityAndApiKey(id,api)

        if (!user) {
            throw new NotFoundException("cannot find user ${params.user} not indexed")
        }
        user
    }

    def compareUsers(params) {
        def user = getUser(params.user,params.api)
        def compareUser = getUser(params.compareUser,params.api)
        if (!params.type) {
            throw MissingParameterException("Missing Or Invalid Parameter Passed")
        }
        SStack matched = new SStack()
        if (params.type == 'bio') {
            matched = PatternMatcher.runPatternMatch(user.profile,compareUser.profile,new BNDM())
        } else if (params.type == 'needs'){
            if (params.needs) {
                matched = PatternMatcher.runPatternMatch(params.needs,compareUser.profile,new BNDM())
            } else{
                matched = PatternMatcher.runPatternMatch(user.needs,compareUser.profile,new BNDM())
            }
        } else if (params.type == 'likes') {
            matched = PatternMatcher.runPatternMatch(user.likes,compareUser.likes,new BNDM())
        } else {
            throw MissingParameterException("Missing Or Invalid Parameter Passed")
        }

        return matched
    }
    def getLocation(params,app) {

        def location = null
        if (params.country && params.state && params.town) {
            location = app.locations.find { it.apiKey == params.api && it.country == params.country.toLowerCase() && it.state == params.state.toLowerCase() && it.town == params.town.toLowerCase()}
        }
        else if (params.country && params.state){
            location = app.locations.find { it.apiKey == params.api && it.country == params.country.toLowerCase() && it.state == params.state.toLowerCase() }
        }
        else if (params.country) {
            location = app.locations.find { it.apiKey == params.api && it.country == params.country.toLowerCase() }
        }
        else {
            location = app.locations.find { it.apiKey == params.api && it.country == 'any' && it.state == 'any' && it.town == 'any'}
        }
       
        location
    }
    def saveLocation(params) {

        def location = null
        if (params.country && params.state && params.town) {
            location = new Location(params.api, params.country.toLowerCase(),params.state.toLowerCase(),params.town.toLowerCase())
        }
        else if (params.country && params.state){
            location = new Location(params.api, params.country.toLowerCase(),params.state.toLowerCase())
        }
        else if (params.country) {
            location = new Location(params.api, params.country.toLowerCase())
        }
        else {
            location = new Location(params.api)
        }
        if (!location) {
            throw new NotFoundException("problems creating a new location")
        }
        location
    }

    def deleteUser(params) throws MissingParameterException {
        log.info("info: In deleting User Profile ")
        List matches = []
        Map returnMap = [:]
        try {
            def app = getApplication(params.api)
            def user = getUser(params.user,params.api)
            List words = user.profile.split(",")
            List likes = user.likes.split(",")
            likes.each { words.add(it)}
            def location = getLocation(params,app)
            for (def word in words) {
                def keyw = location.keywords.find { it.apiKey == params.api && it.keyword == word }
                keyw.removeFromUsers(user)
                keyw.save(flush:true)
            }
            user.delete(flush:true)
            return "success"
        }
        catch (NotFoundException e) {
            return "not success " + e.message
        }
        catch (e) {
            return "not success: exception found"
        }
    }

    def matchMethod(params) throws MissingParameterException {
        log.info("info: In Matching Profile ")
        List matches = []
        Map returnMap = [:]
        try {
            def app = getApplication(params.api)
            def user = getUser(params.user,params.api)
            def location = getLocation(params,app)
            String[] words = user.profile.split(",")
            
            for (def word in words) {
                def keyw = location.keywords.find { it.apiKey == params.api && it.keyword == word && it.profileType == params.type}
                if (keyw) {
                    for (def usr in keyw.users) {
                        if (usr.identity != user.identity) {
                            matches.add(usr.identity)
                        }
                    }
                }
            }
            returnMap.put("message","success")
            returnMap.put("users",matches)
            return returnMap
        }
        catch (NotFoundException e) {
            returnMap.put("message","not success " + e.message)
            returnMap.put("users",matches)
            return returnMap
        }
        catch (e) {
            returnMap.put("message","not success: exception found")
            returnMap.put("users",matches)
            return returnMap
        }
    }
    def likesToLikesMethod(params) throws MissingParameterException {
        log.info("info: In likes to like Profile ")
        List matches = []
        Map returnMap = [:]
        try {
            def app = getApplication(params.api)
            def user = getUser(params.user,params.api)
            def location = getLocation(params,app)
            String[] words = user.likes.split(",")

            for (def word in words) {
                def keyw = location.keywords.find { it.apiKey == params.api && it.keyword == word && it.profileType == params.type}
                if (keyw) {
                    for (def usr in keyw.users) {
                        if (usr.identity != user.identity) {
                            matches.add(usr.identity)
                        }
                    }
                }
            }
            returnMap.put("message","success")
            returnMap.put("users",matches)
            return returnMap
        }
        catch (NotFoundException e) {
            returnMap.put("message","not success " + e.message)
            returnMap.put("users",matches)
            return returnMap
        }
        catch (e) {
            returnMap.put("message","not success: exception found")
            returnMap.put("users",matches)
            return returnMap
        }
    }

    def needsToProfileMethod(params, stemmed) throws MissingParameterException {
        log.info("info: In Collaborate Profile Matching ")
        List matches = []
        Map returnMap = [:]
        def user = null
        try {
            def app = getApplication(params.api)
            if (params.user) {
                user = getUser(params.user,params.api)
                if (!user) {
                    throw new NotFoundException("problems finding specified user")
                }
                String[] needWords = user.needs.split(",")
                stemmed = needWords
            }
            
            def location = getLocation(params,app) //test make sure location
            if (!location) {
                throw new NotFoundException("problems finding specified location")
            }
            for (def word in stemmed) {
                def keyw = location.keywords.find { it.keyword == word && it.profileType == params.type}
                if (keyw) {
                    for (def usr in keyw.users) {
                        if (user) {
                            if (usr.identity != user.identity) {
                                matches.add(usr.identity)
                            }
                        }
                        else {
                            matches.add(usr.identity)
                        }
                    }
                }
            }
        
            returnMap.put("message","success")
            returnMap.put("users",matches)
            return returnMap
        }
        catch (NotFoundException e) {
            returnMap.put("message","not success " + e.message)
            returnMap.put("users",matches)
            return returnMap
        }
        catch (e) {
            returnMap.put("message","not success: exception found")
            returnMap.put("users",matches)
            return returnMap
        }
    }

    def indexUser(params,words){

        log.info("In User Profile Indexing")
        def app = Application.findByApi(params.api)

        if (!app) {
            app = new Application(name: params.name, api: params.api)
            if ( !app.save(flush:true)){app.errors.each { println it}}
        }

        def keyw = null

        def location = getLocation(params,app)
        if (!location) {
            location = saveLocation(params)
            if ( !location.save(flush:true)){location.errors.each { println it}}
            app.addToLocations(location)
            if ( !app.save(flush:true)){app.errors.each { println it}}
        }

        def user = UserIdentity.findByIdentityAndApiKey(params.user,params.api)

        if (!user) {
            user = new UserIdentity(identity: params.user,profile: words.toStoreString(),apiKey: params.api,likes:"")
            if ( !user.save(flush:true)){user.errors.each { println it}}
        }
        else {
            //we want to reprofile the user as they already exist
            //we delete the user and reprofile
            log.info("reprofiling user ${params.user}")
            def message = deleteUser(params)
            if ( message == "success") {
                log.info("deleted user")
                user = new UserIdentity(identity: params.user,profile: words.toStoreString(),apiKey: params.api,likes:"")
                if ( !user.save(flush:true)){user.errors.each { println it}}
            }
            else {
                log.info("problems deleting")
            }
        }
        for ( word in words) {
          
            keyw = location.keywords.find { it.apiKey == params.api && it.keyword == word && it.profileType == params.type}
            if (!keyw) {
                log.info("storing new")
                
                keyw = new Keyword(keyword: word,profileType: params.type,apiKey: params.api)
                if ( !keyw.save(flush:true)){keyw.errors.each { println it}}
               
                location.addToKeywords(keyw)
                if ( !location.save(flush:true)){app.errors.each { println it}}
            }
            keyw.addToUsers(user)
            try {
                keyw.save(flush:true)
            }
            catch(org.springframework.dao.OptimisticLockingFailureException e) {
                // deal with exception
                log.info("locking error")
            }
        }
        if ( !app.save(flush:true)){app.errors.each { println it}}
    }

    def indexUserLikes(params,words){

        log.info("In User Profile Indexing")
        def app = Application.findByApi(params.api)

        if (!app) {
            app = new Application(name: params.name, api: params.api)
            if ( !app.save(flush:true)){app.errors.each { println it}}
        }

        def keyw = null

        def location = getLocation(params,app)
        if (!location) {
            location = saveLocation(params)
            if ( !location.save(flush:true)){location.errors.each { println it}}
            app.addToLocations(location)
            if ( !app.save(flush:true)){app.errors.each { println it}}
        }

        def user = UserIdentity.findByIdentityAndApiKey(params.user,params.api)

        if (!user) {
            user = new UserIdentity(identity: params.user,likes: words,apiKey: params.api)
            if ( !user.save(flush:true)){user.errors.each { println it}}
        }
        else {
            user.likes = words
            if ( !user.save(flush:true)){user.errors.each { println it}}
            
        }
        String[] wordlist = words.split(',')
        for ( word in wordlist) {
            keyw = location.keywords.find { it.apiKey == params.api && it.keyword == word && it.profileType == params.type}
            if (!keyw) {
                keyw = new Keyword(keyword: word,profileType: params.type,apiKey: params.api)
                if ( !keyw.save(flush:true)){keyw.errors.each { println it}}
                location.addToKeywords(keyw)
                if ( !location.save(flush:true)){app.errors.each { println it}}
            }
            keyw.addToUsers(user)
            try {
                keyw.save(flush:true)
            }
            catch(org.springframework.dao.OptimisticLockingFailureException e) {
                // deal with exception
                log.info("locking error")
            }
        }
        if ( !app.save(flush:true)){app.errors.each { println it}}
    }
}
