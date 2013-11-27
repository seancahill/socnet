package socnet

class Location {
    String country
    String state
    String town
    String apiKey
    static hasMany = [keywords: Keyword]
    static mapping = {
        country index:true
        version false
    }
    Location() {
        country = "any"
        state = "any"
        town = "any"
    }
    Location(String api) {
        apiKey = api
        country = 'any'
        state = "any"
        town = "any"
    }
    Location(String api, String co) {
        apiKey = api
        country = co.toLowerCase()
        state = "any"
        town = "any"
    }
    Location(String api, String co, String st) {
        apiKey = api
        country = co.toLowerCase()
        state = st.toLowerCase()
        town = "any"
    }
    Location(String api,String co,String st, String twn) {
        apiKey = api
        country = co.toLowerCase()
        state = st.toLowerCase()
        town = twn.toLowerCase()
    }
}
