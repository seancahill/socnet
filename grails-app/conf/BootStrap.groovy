import socnet.UserIdentity
import socnet.Application
import socnet.Keyword
import socnet.DemoUser
import socnet.ProfileService
import grails.converters.*
import edu.ncirl.*

class BootStrap {
    def profileService
    def init = { servletContext ->
        
        if (!DemoUser.count()) {
            def api = "92a68c27-d1b3-4cc2-ac86-e477bcdcf239"

            def user1 = new DemoUser("Ireland","Dublin","Dalkey",
                "i am a web developer with experience in php,python,java.",
                "i am looking to collaborate on social networking applications",
                "sailing,tennis,horse racing",
                "Sean Sampson","123456" )
            user1.save()
            def params = [ "country": user1.country,"state": user1.state,"town": user1.town,"name": "demo", "api": api,"user": user1.identity,"profile": user1.bio,"type": "bio"]
            SStack stack1 = Parser.StripSearch(user1.bio)
            String stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
            SStack stemmed = Stemmer.StemText(stopped)
            String likes = user1.likes
            try{
                profileService.indexUser(params,stemmed)
                params = [ "country": user1.country,"state": user1.state,"town": user1.town,"name": "demo", "api": api,"user":user1.identity,"likes": user1.likes,"type": "likes"]
                profileService.indexUserLikes(params,likes)
            }
            catch (e) {
                log.info("error")
            }


            def user2 = new DemoUser("Ireland","Dublin","Dalkey",
                'i am a programmer with experience in php,python,java.',
                "i am looking to collorate on web based animation projects",
                "golf,walking",
                "Brian Barnes","123457" )
            user2.save()
            params = [ "country": user2.country,"state": user2.state,"town": user2.town,"name": "demo", "api": api,"user":user2.identity,"profile": user2.bio,"type": "bio"]
            stack1 = Parser.StripSearch(user2.bio)
            stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
            stemmed = Stemmer.StemText(stopped)
            likes = user2.likes
            try{
                profileService.indexUser(params,stemmed)
                params = [ "country": user2.country,"state": user2.state,"town": user2.town,"name": "demo", "api": api,"user":user2.identity,"likes": user2.likes,"type": "likes"]
                profileService.indexUserLikes(params,likes)
            }
            catch (e) {
                log.info("error")
            }

            def user3 = new DemoUser("Ireland","Dublin","Dalkey",
                'i am a web developer currently developing a local based social network',
                "i am looking to collaborate on iphone app projects",
                "football, squash",
                "Robert Spiller" ,"123458")
            user3.save()
            params = [ "country": user3.country,"state": user3.state,"town": user3.town,"name": "demo", "api": api,"user":user3.identity,"profile": user3.bio,"type": "bio"]
            stack1 = Parser.StripSearch(user3.bio)
            stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
            stemmed = Stemmer.StemText(stopped) //bug in stemmer not getting last word
            likes = user3.likes
            try{
                profileService.indexUser(params,stemmed)
                params = [ "country": user3.country,"state": user3.state,"town": user3.town,"name": "demo", "api": api,"user":user3.identity,"likes": user3.likes,"type": "likes"]
                profileService.indexUserLikes(params,likes)
            }
            catch (e) {
                log.info("error")
            }
            
            def user4 = new DemoUser("Ireland","Dublin","Dalkey",
                'i am a book illustrator mainly involved with childrens books',
                "i am looking to collaborate with childrens book authors",
                "tennis, sailing",
                "Sally Baker" ,"123459")
            user4.save()
            params = [ "country": user4.country,"state": user4.state,"town": user4.town,"name": "demo", "api": api,"user":user4.identity,"profile": user4.bio,"type": "bio"]
            stack1 = Parser.StripSearch(user4.bio)
            stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
            stemmed = Stemmer.StemText(stopped) //bug in stemmer not getting last word
            likes = user4.likes
            try{
                profileService.indexUser(params,stemmed)
                params = [ "country": user4.country,"state": user4.state,"town": user4.town,"name": "demo", "api": api,"user":user4.identity,"likes": user4.likes,"type": "likes"]
                profileService.indexUserLikes(params,likes)
            }
            catch (e) {
                log.info("error")
            }
            
            def user5 = new DemoUser("Ireland","Dublin","Dalkey",
                'i am a graphic designer involved in web animation',
                "i am looking to collaborate web developers and designers",
                "tennis, squash",
                "Sarah Shannon" ,"123460")
            user5.save()
            params = [ "country": user5.country,"state": user5.state,"town": user5.town,"name": "demo", "api": api,"user":user5.identity,"profile": user5.bio,"type": "bio"]
            stack1 = Parser.StripSearch(user5.bio)
            stopped = Stopper.RemoveStops(stack1.toString(),profileService.allStops(api))
            stemmed = Stemmer.StemText(stopped) //bug in stemmer not getting last word
            likes = user5.likes
            try{
                profileService.indexUser(params,stemmed)
                params = [ "country": user5.country,"state": user5.state,"town": user5.town,"name": "demo", "api": api,"user":user5.identity,"likes": user5.likes,"type": "likes"]
                profileService.indexUserLikes(params,likes)
            }
            catch (e) {
                log.info("error")
            }

        }

        JSON.registerObjectMarshaller(Application) {
            def returnArray = [:]
            returnArray['name'] = it.name
            returnArray['keywords'] = it.keywords
            return returnArray
        }

              
    }
    def destroy = {
    }
}
