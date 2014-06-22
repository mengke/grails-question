import org.apache.commons.codec.digest.DigestUtils
import org.ibntab.User

fixture {
    build {
        
        peter(User,
                username: "peter",
                password: "password")
        
        dilbert(User,
                username: "dilbert",
                password: "password")
        
        spammer(User,
                username: "spammer",
                password: "spam")

        mengke(User,
                username: "mengke",
                password: "mengke")

        etta(User,
                username: "etta",
                password: "etta")

        johndoe(User,
                username: "john.doe",
                password: "john.doe")

        tom(User,
                username: "tom.riddle",
                password: "tom.riddle")

        harry(User,
                username: "harry.potter",
                password: "harry.potter")

        jerry(User,
                username: "jerry",
                password: "jerry")

        king(User,
                username: "king",
                password: "king")

    }
}
