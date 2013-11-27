package socnet

class Application {
    String name
    String api
    static hasMany = [locations: Location]
    static mapping = {
        api index:true
        version false
    }
    static constraints = {
        name(blank : false)
        api(blank: false)
    }
    boolean equals(other) { other?.id == id }

    int hashCode() { id ?: 0 }
}
