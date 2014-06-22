package org.ibntab

import grails.test.mixin.TestFor
import org.ibntab.common.ConstraintUnitSpec
import spock.lang.Unroll

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(User)
class UserSpec extends ConstraintUnitSpec {

    def setup() {
        mockForConstraintsTests(User, [new User(username: 'mengke')])
    }

    def cleanup() {
    }

    @Unroll("user #field is #error using #val")
    def "test user username constraints"() {
        when:
        def obj = new User("$field": val)

        then:
        validateConstraints(obj, field, error)

        where:
        error          | field             | val
        'nullable'     | 'username'        | null
        'nullable'     | 'username'        | ''
        'size'         | 'username'        | word(3)
        'size'         | 'username'        | word(21)
        'unique'       | 'username'        | 'mengke'
        'valid'        | 'username'        | word(4)
        'valid'        | 'username'        | word(20)
        'valid'        | 'username'        | word(15)

    }
}
