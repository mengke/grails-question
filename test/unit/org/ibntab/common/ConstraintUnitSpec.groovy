package org.ibntab.common

import spock.lang.Specification

/**
 * Created by ibntab on 14/6/17.
 *
 */
abstract class ConstraintUnitSpec extends Specification {

    protected String word(Integer length) {
        'a' * length
    }

    protected String getEmail(Boolean valid) {
        valid ? "ke.meng@qunar.com" : "ke.meng@qunar"
    }

    protected String getUrl(Boolean valid) {
        valid ? "http://www.google.com" : "http:/ww.helloworld.com"
    }

    protected void validateConstraints(obj, field, error) {
        def validated = obj.validate()
        if (error && error != 'valid') {
            assert !validated
            assert obj.errors[field]
            assert error == obj.errors[field]
        } else {
            assert !obj.errors[field]
        }
    }
}
