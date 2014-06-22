package org.ibntab

import grails.gsp.TagLib
import groovy.transform.CompileStatic
import org.codehaus.groovy.grails.web.mapping.UrlMapping
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.pages.TagLibraryLookup
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.codehaus.groovy.grails.web.util.TypeConvertingMap
import org.springframework.context.MessageSource
import org.springframework.context.NoSuchMessageException
import org.springframework.util.StringUtils
import org.springframework.web.servlet.support.RequestContextUtils

@TagLib
class BootstrapTagLib {
    static namespace = "bs"
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    MessageSource messageSource
    TagLibraryLookup gspTagLibraryLookup

    @CompileStatic
    String messageHelper(String code, Object defaultMessage = null, List args = null, Locale locale = null) {
        if (locale == null) {
            locale = GrailsWebRequest.lookup().getLocale()
        }
        def message
        try {
            message = messageSource.getMessage(code, args == null ? null : args.toArray(), locale)
        }
        catch (NoSuchMessageException e) {
            if (defaultMessage != null) {
                if (defaultMessage instanceof Closure) {
                    message = defaultMessage()
                }
                else {
                    message = defaultMessage as String
                }
            }
        }
        return message
    }

    @CompileStatic
    static Locale resolveLocale(Object localeAttr) {
        Locale locale
        if (localeAttr instanceof Locale) {
            locale = (Locale)localeAttr
        } else if (localeAttr != null) {
            locale = StringUtils.parseLocaleString(localeAttr.toString())
        }
        if (locale == null) {
            locale = GrailsWebRequest.lookup().getLocale()
            if (locale == null) {
                locale = Locale.getDefault()
            }
        }
        return locale
    }

    /**
     * Outputs the given boolean as the specified text label. If the
     * <code>true</code> and <code>false</code> option are not given,
     * then the boolean is output using the default label.<br/>
     *
     * Examples:<br/>
     *
     * &lt;g:formatBoolean boolean="${myBoolean}" /&gt;<br/>
     * &lt;g:formatBoolean boolean="${myBoolean}" true="True!" false="False!" /&gt;<br/>
     *
     * @emptyTag
     *
     * @attr boolean REQUIRED the boolean to output
     * @attr true text label for boolean true value
     * @attr false text label for boolean false value
     * @attr trueLabel
     * @attr falseLabel
     * @attr locale Force the locale for formatting.
     */
    Closure formatBoolean = { attrs ->
        def writer = out
        if (!attrs.containsKey("boolean")) {
            throwTagError("Tag [formatBoolean] is missing required attribute [boolean]")
        }

        def b = attrs['boolean']
        if (b == null) {
            return
        }

        if (!(b instanceof Boolean)) {
            b = Boolean.valueOf(b)
        }

        def trueLabel = attrs['trueLabel']
        if (StringUtils.isEmpty(trueLabel)) {
            trueLabel = "label label-success"
        } else {
            trueLabel = "label label-${trueLabel}"
        }
        def falseLabel = attrs['falseLabel']
        if (StringUtils.isEmpty(falseLabel)) {
            falseLabel = "label label-default"
        } else {
            falseLabel = "label label-${falseLabel}"
        }

        def locale = resolveLocale(attrs.locale)
        String message = null
        if (b) {
            if (attrs.containsKey('true')) {
                message = attrs['true']
            }
            message = messageHelper('boolean.true', { messageHelper('default.boolean.true', 'True', null, locale) }, null, locale)
            writer << "<span class=\"${trueLabel}\">${message}</span>"
        } else {
            if (attrs.containsKey('false')) {
                message = attrs['false']
            }
            message = messageHelper('boolean.false', { messageHelper('default.boolean.false', 'False', null, locale) }, null, locale)
            writer << "<span class=\"${falseLabel}\">${message}</span>"
        }

    }

    /**
     * Creates next/previous links to support pagination for the current controller.<br/>
     *
     * &lt;g:paginate total="${Account.count()}" /&gt;<br/>
     *
     * @emptyTag
     *
     * @attr total REQUIRED The total number of results to paginate
     * @attr action the name of the action to use in the link, if not specified the default action will be linked
     * @attr controller the name of the controller to use in the link, if not specified the current controller will be linked
     * @attr id The id to use in the link
     * @attr params A map containing request parameters
     * @attr prev The text to display for the previous link (defaults to "Previous" as defined by default.paginate.prev property in I18n messages.properties)
     * @attr next The text to display for the next link (defaults to "Next" as defined by default.paginate.next property in I18n messages.properties)
     * @attr omitPrev Whether to not show the previous link (if set to true, the previous link will not be shown)
     * @attr omitNext Whether to not show the next link (if set to true, the next link will not be shown)
     * @attr omitFirst Whether to not show the first link (if set to true, the first link will not be shown)
     * @attr omitLast Whether to not show the last link (if set to true, the last link will not be shown)
     * @attr max The number of records displayed per page (defaults to 10). Used ONLY if params.max is empty
     * @attr maxsteps The number of steps displayed for pagination (defaults to 10). Used ONLY if params.maxsteps is empty
     * @attr offset Used only if params.offset is empty
     * @attr mapping The named URL mapping to use to rewrite the link
     * @attr fragment The link fragment (often called anchor tag) to use
     */
    Closure paginate = { Map attrsMap ->
        TypeConvertingMap attrs = (TypeConvertingMap)attrsMap
        def writer = out

        if (attrs.total == null) {
            throwTagError("Tag [paginate] is missing required attribute [total]")
        }
        writer << "<ul class=\"pagination\">"
        def messageSource = grailsAttributes.messageSource
        def locale = RequestContextUtils.getLocale(request)

        def total = attrs.int('total') ?: 0
        def offset = params.int('offset') ?: 0
        def max = params.int('max')
        def maxsteps = (attrs.int('maxsteps') ?: 10)

        if (!offset) offset = (attrs.int('offset') ?: 0)
        if (!max) max = (attrs.int('max') ?: 10)

        Map linkParams = [:]
        if (attrs.params instanceof Map) linkParams.putAll((Map)attrs.params)
        linkParams.offset = offset - max
        linkParams.max = max
        if (params.sort) linkParams.sort = params.sort
        if (params.order) linkParams.order = params.order

        Map linkTagAttrs = [:]
        def action
        if (attrs.containsKey('mapping')) {
            linkTagAttrs.mapping = attrs.mapping
            action = attrs.action
        } else {
            action = attrs.action ?: params.action
        }
        if (action) {
            linkTagAttrs.action = action
        }
        if (attrs.controller) {
            linkTagAttrs.controller = attrs.controller
        }
        if (attrs.containsKey(UrlMapping.PLUGIN)) {
            linkTagAttrs.put(UrlMapping.PLUGIN, attrs.get(UrlMapping.PLUGIN))
        }
        if (attrs.containsKey(UrlMapping.NAMESPACE)) {
            linkTagAttrs.put(UrlMapping.NAMESPACE, attrs.get(UrlMapping.NAMESPACE))
        }
        if (attrs.id != null) {
            linkTagAttrs.id = attrs.id
        }
        if (attrs.fragment != null) {
            linkTagAttrs.fragment = attrs.fragment
        }
        linkTagAttrs.params = linkParams

        // determine paging variables
        def steps = maxsteps > 0
        int currentstep = ((offset / max) as int) + 1
        int firststep = 1
        int laststep = Math.round(Math.ceil(total / max)) as int

        // display previous link when not on firststep unless omitPrev is true
        if (currentstep > firststep && !attrs.boolean('omitPrev')) {
            linkTagAttrs.put('class', 'prevLink')
            linkParams.offset = offset - max
            writer << "<li>"
            writer << callLink((Map)linkTagAttrs.clone()) {
                ("&laquo;")
            }
            writer << "</li>"
        }

        // display steps when steps are enabled and laststep is not firststep
        if (steps && laststep > firststep) {
            linkTagAttrs.put('class', 'step')

            // determine begin and endstep paging variables
            int beginstep = currentstep - (Math.round(maxsteps / 2.0d) as int) + (maxsteps % 2)
            int endstep = currentstep + (Math.round(maxsteps / 2.0d) as int) - 1

            if (beginstep < firststep) {
                beginstep = firststep
                endstep = maxsteps
            }
            if (endstep > laststep) {
                beginstep = laststep - maxsteps + 1
                if (beginstep < firststep) {
                    beginstep = firststep
                }
                endstep = laststep
            }

            // display firststep link when beginstep is not firststep
            if (beginstep > firststep && !attrs.boolean('omitFirst')) {
                linkParams.offset = 0
                writer << "<li>"
                writer << callLink((Map)linkTagAttrs.clone()) {firststep.toString()}
                writer << "</li>"
            }
            //show a gap if beginstep isn't immediately after firststep, and if were not omitting first or rev
            if (beginstep > firststep+1 && (!attrs.boolean('omitFirst') || !attrs.boolean('omitPrev')) ) {
                writer << '<li class="disabled"><a href="#">..</a></li>'
            }

            // display paginate steps
            (beginstep..endstep).each { int i ->
                if (currentstep == i) {
                    writer << "<li class=\"active\">"
                    writer << callLink((Map)linkTagAttrs.clone()) {i.toString()}
                    writer << "</li>"
                }
                else {
                    linkParams.offset = (i - 1) * max
                    writer << "<li>"
                    writer << callLink((Map)linkTagAttrs.clone()) {i.toString()}
                    writer << "</li>"
                }
            }

            //show a gap if beginstep isn't immediately before firststep, and if were not omitting first or rev
            if (endstep+1 < laststep && (!attrs.boolean('omitLast') || !attrs.boolean('omitNext'))) {
                writer << '<li class="disabled"><a href="#">..</a></li>'
            }
            // display laststep link when endstep is not laststep
            if (endstep < laststep && !attrs.boolean('omitLast')) {
                linkParams.offset = (laststep - 1) * max
                writer << "<li>"
                writer << callLink((Map)linkTagAttrs.clone()) { laststep.toString() }
                writer << "</li>"
            }
        }

        // display next link when not on laststep unless omitNext is true
        if (currentstep < laststep && !attrs.boolean('omitNext')) {
            linkTagAttrs.put('class', 'nextLink')
            linkParams.offset = offset + max
            writer << "<li>"
            writer << callLink((Map)linkTagAttrs.clone()) {
                "&raquo;"
            }
            writer << "</li>"
        }
        writer << "</ul>"
    }

    private callLink(Map attrs, Object body) {
        GroovyPage.captureTagOutput(gspTagLibraryLookup, 'g', 'link', attrs, body, webRequest)
    }
}
