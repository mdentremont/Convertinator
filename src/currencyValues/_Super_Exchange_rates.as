/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Exchange_rates.as.
 */

package currencyValues
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.util.FiberUtils;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.binding.utils.ChangeWatcher;
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.PropertyChangeEvent;
import mx.validators.ValidationResult;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_Exchange_rates extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        currencyValues.Fx.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _Exchange_ratesEntityMetadata;

    /**
     * properties
     */
    private var _internal_basecurrency : String;
    private var _internal_fx_date : String;
    private var _internal_fx : ArrayCollection;
    model_internal var _internal_fx_leaf:currencyValues.Fx;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_Exchange_rates()
    {
        _model = new _Exchange_ratesEntityMetadata(this);

        // Bind to own data properties for cache invalidation triggering
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "basecurrency", model_internal::setterListenerBasecurrency));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "fx_date", model_internal::setterListenerFx_date));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "fx", model_internal::setterListenerFx));

    }

    /**
     * data property getters
     */

    [Bindable(event="propertyChange")]
    public function get basecurrency() : String
    {
        return _internal_basecurrency;
    }

    [Bindable(event="propertyChange")]
    public function get fx_date() : String
    {
        return _internal_fx_date;
    }

    [Bindable(event="propertyChange")]
    public function get fx() : ArrayCollection
    {
        return _internal_fx;
    }

    /**
     * data property setters
     */

    public function set basecurrency(value:String) : void
    {
        var oldValue:String = _internal_basecurrency;
        if (oldValue !== value)
        {
            _internal_basecurrency = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "basecurrency", oldValue, _internal_basecurrency));
        }
    }

    public function set fx_date(value:String) : void
    {
        var oldValue:String = _internal_fx_date;
        if (oldValue !== value)
        {
            _internal_fx_date = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fx_date", oldValue, _internal_fx_date));
        }
    }

    public function set fx(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_fx;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_fx = value;
            }
            else if (value is Array)
            {
                _internal_fx = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of fx must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fx", oldValue, _internal_fx));
        }
    }

    /**
     * Data property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */

    model_internal function setterListenerBasecurrency(value:flash.events.Event):void
    {
        _model.invalidateDependentOnBasecurrency();
    }

    model_internal function setterListenerFx_date(value:flash.events.Event):void
    {
        _model.invalidateDependentOnFx_date();
    }

    model_internal function setterListenerFx(value:flash.events.Event):void
    {
        if (value is mx.events.PropertyChangeEvent)
        {
            if (mx.events.PropertyChangeEvent(value).newValue)
            {
                mx.events.PropertyChangeEvent(value).newValue.addEventListener(mx.events.CollectionEvent.COLLECTION_CHANGE, model_internal::setterListenerFx);
            }
        }
        _model.invalidateDependentOnFx();
    }


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;
        if (!_model.basecurrencyIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_basecurrencyValidationFailureMessages);
        }
        if (!_model.fx_dateIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_fx_dateValidationFailureMessages);
        }
        if (!_model.fxIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_fxValidationFailureMessages);
        }

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _Exchange_ratesEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _Exchange_ratesEntityMetadata) : void
    {
        var oldValue : _Exchange_ratesEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }

    model_internal var _doValidationCacheOfBasecurrency : Array = null;
    model_internal var _doValidationLastValOfBasecurrency : String;

    model_internal function _doValidationForBasecurrency(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfBasecurrency != null && model_internal::_doValidationLastValOfBasecurrency == value)
           return model_internal::_doValidationCacheOfBasecurrency ;

        _model.model_internal::_basecurrencyIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isBasecurrencyAvailable && _internal_basecurrency == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "basecurrency is required"));
        }

        model_internal::_doValidationCacheOfBasecurrency = validationFailures;
        model_internal::_doValidationLastValOfBasecurrency = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfFx_date : Array = null;
    model_internal var _doValidationLastValOfFx_date : String;

    model_internal function _doValidationForFx_date(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfFx_date != null && model_internal::_doValidationLastValOfFx_date == value)
           return model_internal::_doValidationCacheOfFx_date ;

        _model.model_internal::_fx_dateIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isFx_dateAvailable && _internal_fx_date == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "fx_date is required"));
        }

        model_internal::_doValidationCacheOfFx_date = validationFailures;
        model_internal::_doValidationLastValOfFx_date = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfFx : Array = null;
    model_internal var _doValidationLastValOfFx : ArrayCollection;

    model_internal function _doValidationForFx(valueIn:Object):Array
    {
        var value : ArrayCollection = valueIn as ArrayCollection;

        if (model_internal::_doValidationCacheOfFx != null && model_internal::_doValidationLastValOfFx == value)
           return model_internal::_doValidationCacheOfFx ;

        _model.model_internal::_fxIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isFxAvailable && _internal_fx == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "fx is required"));
        }

        model_internal::_doValidationCacheOfFx = validationFailures;
        model_internal::_doValidationLastValOfFx = value;

        return validationFailures;
    }
    

}

}
