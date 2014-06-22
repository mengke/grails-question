import grails.util.Environment
import org.ibntab.Role
import org.ibntab.User
import org.ibntab.UserRole

class BootStrap {

    def fixtureLoader

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new User(username: 'admin', password: 'password')
        testUser.save(flush: true)

        UserRole.create testUser, adminRole, true

        assert User.count() == 1
        assert Role.count() == 2
        assert UserRole.count() == 1

        if ((System.getProperty("load.fixtures") || Environment.current == Environment.DEVELOPMENT) && User.count() < 2) {
            println "Loading fixture data..."
            fixtureLoader.with {
                load("users")
            }
        }
    }
    def destroy = {
    }
}
