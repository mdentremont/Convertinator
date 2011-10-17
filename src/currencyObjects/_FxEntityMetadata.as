
/**
 * This is a generated class and is not intended for modification.  
 */
package currencyObjects
{
import com.adobe.fiber.styles.IStyle;
import com.adobe.fiber.styles.Style;
import com.adobe.fiber.styles.StyleValidator;
import com.adobe.fiber.valueobjects.AbstractEntityMetadata;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import mx.events.ValidationResultEvent;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IModelType;
import mx.events.PropertyChangeEvent;

use namespace model_internal;

[ExcludeClass]
internal class _FxEntityMetadata extends com.adobe.fiber.valueobjects.AbstractEntityMetadata
{
    private static var emptyArray:Array = new Array();

    model_internal static var allProperties:Array = new Array("basecurrency", "currency_code", "rate");
    model_internal static var allAssociationProperties:Array = new Array();
    model_internal static var allRequiredProperties:Array = new Array("basecurrency", "currency_code", "rate");
    model_internal static var allAlwaysAvailableProperties:Array = new Array("basecurrency", "currency_code", "rate");
    model_internal static var guardedProperties:Array = new Array();
    model_internal static var dataProperties:Array = new Array("basecurrency", "currency_code", "rate");
    model_internal static var derivedProperties:Array = new Array();
    model_internal static var collectionProperties:Array = new Array();
    model_internal static var collectionBaseMap:Object;
    model_internal static var entityName:String = "Fx";
    model_internal static var dependentsOnMap:Object;
    model_internal static var dependedOnServices:Array = new Array();

    
    model_internal var _basecurrencyIsValid:Boolean;
    model_internal var _basecurrencyValidator:com.adobe.fiber.styles.StyleValidator;
    model_internal var _basecurrencyIsValidCacheInitialized:Boolean = false;
    model_internal var _basecurrencyValidationFailureMessages:Array;
    
    model_internal var _rateIsValid:Boolean;
    model_internal var _rateValidator:com.adobe.fiber.styles.StyleValidator;
    model_internal var _rateIsValidCacheInitialized:Boolean = false;
    model_internal var _rateValidationFailureMessages:Array;

    model_internal var _instance:_Super_Fx;
    model_internal static var _nullStyle:com.adobe.fiber.styles.Style = new com.adobe.fiber.styles.Style();

    public function _FxEntityMetadata(value : _Super_Fx)
    {
        // initialize property maps
        if (model_internal::dependentsOnMap == null)
        {
            // depenents map
            model_internal::dependentsOnMap = new Object();
            model_internal::dependentsOnMap["basecurrency"] = new Array();
            model_internal::dependentsOnMap["currency_code"] = new Array();
            model_internal::dependentsOnMap["rate"] = new Array();

            // collection base map
            model_internal::collectionBaseMap = new Object()
        }

        model_internal::_instance = value;
        model_internal::_basecurrencyValidator = new StyleValidator(model_internal::_instance.model_internal::_doValidationForBasecurrency);
        model_internal::_basecurrencyValidator.required = true;
        model_internal::_basecurrencyValidator.requiredFieldError = "basecurrency is required";
        //model_internal::_basecurrencyValidator.source = model_internal::_instance;
        //model_internal::_basecurrencyValidator.property = "basecurrency";
        model_internal::_rateValidator = new StyleValidator(model_internal::_instance.model_internal::_doValidationForRate);
        model_internal::_rateValidator.required = true;
        model_internal::_rateValidator.requiredFieldError = "rate is required";
        //model_internal::_rateValidator.source = model_internal::_instance;
        //model_internal::_rateValidator.property = "rate";
    }

    override public function getEntityName():String
    {
        return model_internal::entityName;
    }

    override public function getProperties():Array
    {
        return model_internal::allProperties;
    }

    override public function getAssociationProperties():Array
    {
        return model_internal::allAssociationProperties;
    }

    override public function getRequiredProperties():Array
    {
         return model_internal::allRequiredProperties;   
    }

    override public function getDataProperties():Array
    {
        return model_internal::dataProperties;
    }

    override public function getGuardedProperties():Array
    {
        return model_internal::guardedProperties;
    }

    override public function getUnguardedProperties():Array
    {
        return model_internal::allAlwaysAvailableProperties;
    }

    override public function getDependants(propertyName:String):Array
    {
       if (model_internal::dataProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a data property of entity Fx");  
            
       return model_internal::dependentsOnMap[propertyName] as Array;  
    }

    override public function getDependedOnServices():Array
    {
        return model_internal::dependedOnServices;
    }

    override public function getCollectionProperties():Array
    {
        return model_internal::collectionProperties;
    }

    override public function getCollectionBase(propertyName:String):String
    {
        if (model_internal::collectionProperties.indexOf(propertyName) == -1)
            throw new Error(propertyName + " is not a collection property of entity Fx");  

        return model_internal::collectionBaseMap[propertyName];
    }

    override public function getAvailableProperties():com.adobe.fiber.valueobjects.IPropertyIterator
    {
        return new com.adobe.fiber.valueobjects.AvailablePropertyIterator(this);
    }

    override public function getValue(propertyName:String):*
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity Fx");
        }

        return model_internal::_instance[propertyName];
    }

    override public function setValue(propertyName:String, value:*):void
    {
        if (model_internal::dataProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " is not a data property of entity Fx");
        }

        model_internal::_instance[propertyName] = value;
    }

    override public function getMappedByProperty(associationProperty:String):String
    {
        switch(associationProperty)
        {
            default:
            {
                return null;
            }
        }
    }

    override public function getPropertyLength(propertyName:String):int
    {
        switch(propertyName)
        {
            default:
            {
                return 0;
            }
        }
    }

    override public function isAvailable(propertyName:String):Boolean
    {
        if (model_internal::allProperties.indexOf(propertyName) == -1)
        {
            throw new Error(propertyName + " does not exist for entity Fx");
        }

        if (model_internal::allAlwaysAvailableProperties.indexOf(propertyName) != -1)
        {
            return true;
        }

        switch(propertyName)
        {
            default:
            {
                return true;
            }
        }
    }

    override public function getIdentityMap():Object
    {
        var returnMap:Object = new Object();
        returnMap["currency_code"] = model_internal::_instance.currency_code;

        return returnMap;
    }

    [Bindable(event="propertyChange")]
    override public function get invalidConstraints():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_invalidConstraints;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_invalidConstraints;        
        }
    }

    [Bindable(event="propertyChange")]
    override public function get validationFailureMessages():Array
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_validationFailureMessages;
        }
    }

    override public function getDependantInvalidConstraints(propertyName:String):Array
    {
        var dependants:Array = getDependants(propertyName);
        if (dependants.length == 0)
        {
            return emptyArray;
        }

        var currentlyInvalid:Array = invalidConstraints;
        if (currentlyInvalid.length == 0)
        {
            return emptyArray;
        }

        var filterFunc:Function = function(element:*, index:int, arr:Array):Boolean
        {
            return dependants.indexOf(element) > -1;
        }

        return currentlyInvalid.filter(filterFunc);
    }

    /**
     * isValid
     */
    [Bindable(event="propertyChange")] 
    public function get isValid() : Boolean
    {
        if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
        {
            return model_internal::_instance.model_internal::_isValid;
        }
        else
        {
            // recalculate isValid
            model_internal::_instance.model_internal::_isValid = model_internal::_instance.model_internal::calculateIsValid();
            return model_internal::_instance.model_internal::_isValid;
        }
    }

    [Bindable(event="propertyChange")]
    public function get isBasecurrencyAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isCurrency_codeAvailable():Boolean
    {
        return true;
    }

    [Bindable(event="propertyChange")]
    public function get isRateAvailable():Boolean
    {
        return true;
    }


    /**
     * derived property recalculation
     */
    public function invalidateDependentOnBasecurrency():void
    {
        if (model_internal::_basecurrencyIsValidCacheInitialized )
        {
            model_internal::_instance.model_internal::_doValidationCacheOfBasecurrency = null;
            model_internal::calculateBasecurrencyIsValid();
        }
    }
    public function invalidateDependentOnRate():void
    {
        if (model_internal::_rateIsValidCacheInitialized )
        {
            model_internal::_instance.model_internal::_doValidationCacheOfRate = null;
            model_internal::calculateRateIsValid();
        }
    }

    model_internal function fireChangeEvent(propertyName:String, oldValue:Object, newValue:Object):void
    {
        this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, propertyName, oldValue, newValue));
    }

    [Bindable(event="propertyChange")]   
    public function get basecurrencyStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    public function get basecurrencyValidator() : StyleValidator
    {
        return model_internal::_basecurrencyValidator;
    }

    model_internal function set _basecurrencyIsValid_der(value:Boolean):void 
    {
        var oldValue:Boolean = model_internal::_basecurrencyIsValid;         
        if (oldValue !== value)
        {
            model_internal::_basecurrencyIsValid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "basecurrencyIsValid", oldValue, value));
        }                             
    }

    [Bindable(event="propertyChange")]
    public function get basecurrencyIsValid():Boolean
    {
        if (!model_internal::_basecurrencyIsValidCacheInitialized)
        {
            model_internal::calculateBasecurrencyIsValid();
        }

        return model_internal::_basecurrencyIsValid;
    }

    model_internal function calculateBasecurrencyIsValid():void
    {
        var valRes:ValidationResultEvent = model_internal::_basecurrencyValidator.validate(model_internal::_instance.basecurrency)
        model_internal::_basecurrencyIsValid_der = (valRes.results == null);
        model_internal::_basecurrencyIsValidCacheInitialized = true;
        if (valRes.results == null)
             model_internal::basecurrencyValidationFailureMessages_der = emptyArray;
        else
        {
            var _valFailures:Array = new Array();
            for (var a:int = 0 ; a<valRes.results.length ; a++)
            {
                _valFailures.push(valRes.results[a].errorMessage);
            }
            model_internal::basecurrencyValidationFailureMessages_der = _valFailures;
        }
    }

    [Bindable(event="propertyChange")]
    public function get basecurrencyValidationFailureMessages():Array
    {
        if (model_internal::_basecurrencyValidationFailureMessages == null)
            model_internal::calculateBasecurrencyIsValid();

        return _basecurrencyValidationFailureMessages;
    }

    model_internal function set basecurrencyValidationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_basecurrencyValidationFailureMessages;

        var needUpdate : Boolean = false;
        if (oldValue == null)
            needUpdate = true;
    
        // avoid firing the event when old and new value are different empty arrays
        if (!needUpdate && (oldValue !== value && (oldValue.length > 0 || value.length > 0)))
        {
            if (oldValue.length == value.length)
            {
                for (var a:int=0; a < oldValue.length; a++)
                {
                    if (oldValue[a] !== value[a])
                    {
                        needUpdate = true;
                        break;
                    }
                }
            }
            else
            {
                needUpdate = true;
            }
        }

        if (needUpdate)
        {
            model_internal::_basecurrencyValidationFailureMessages = value;   
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "basecurrencyValidationFailureMessages", oldValue, value));
            // Only execute calculateIsValid if it has been called before, to update the validationFailureMessages for
            // the entire entity.
            if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
            {
                model_internal::_instance.model_internal::isValid_der = model_internal::_instance.model_internal::calculateIsValid();
            }
        }
    }

    [Bindable(event="propertyChange")]   
    public function get currency_codeStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    [Bindable(event="propertyChange")]   
    public function get rateStyle():com.adobe.fiber.styles.Style
    {
        return model_internal::_nullStyle;
    }

    public function get rateValidator() : StyleValidator
    {
        return model_internal::_rateValidator;
    }

    model_internal function set _rateIsValid_der(value:Boolean):void 
    {
        var oldValue:Boolean = model_internal::_rateIsValid;         
        if (oldValue !== value)
        {
            model_internal::_rateIsValid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rateIsValid", oldValue, value));
        }                             
    }

    [Bindable(event="propertyChange")]
    public function get rateIsValid():Boolean
    {
        if (!model_internal::_rateIsValidCacheInitialized)
        {
            model_internal::calculateRateIsValid();
        }

        return model_internal::_rateIsValid;
    }

    model_internal function calculateRateIsValid():void
    {
        var valRes:ValidationResultEvent = model_internal::_rateValidator.validate(model_internal::_instance.rate)
        model_internal::_rateIsValid_der = (valRes.results == null);
        model_internal::_rateIsValidCacheInitialized = true;
        if (valRes.results == null)
             model_internal::rateValidationFailureMessages_der = emptyArray;
        else
        {
            var _valFailures:Array = new Array();
            for (var a:int = 0 ; a<valRes.results.length ; a++)
            {
                _valFailures.push(valRes.results[a].errorMessage);
            }
            model_internal::rateValidationFailureMessages_der = _valFailures;
        }
    }

    [Bindable(event="propertyChange")]
    public function get rateValidationFailureMessages():Array
    {
        if (model_internal::_rateValidationFailureMessages == null)
            model_internal::calculateRateIsValid();

        return _rateValidationFailureMessages;
    }

    model_internal function set rateValidationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_rateValidationFailureMessages;

        var needUpdate : Boolean = false;
        if (oldValue == null)
            needUpdate = true;
    
        // avoid firing the event when old and new value are different empty arrays
        if (!needUpdate && (oldValue !== value && (oldValue.length > 0 || value.length > 0)))
        {
            if (oldValue.length == value.length)
            {
                for (var a:int=0; a < oldValue.length; a++)
                {
                    if (oldValue[a] !== value[a])
                    {
                        needUpdate = true;
                        break;
                    }
                }
            }
            else
            {
                needUpdate = true;
            }
        }

        if (needUpdate)
        {
            model_internal::_rateValidationFailureMessages = value;   
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rateValidationFailureMessages", oldValue, value));
            // Only execute calculateIsValid if it has been called before, to update the validationFailureMessages for
            // the entire entity.
            if (model_internal::_instance.model_internal::_cacheInitialized_isValid)
            {
                model_internal::_instance.model_internal::isValid_der = model_internal::_instance.model_internal::calculateIsValid();
            }
        }
    }


     /**
     * 
     * @inheritDoc 
     */ 
     override public function getStyle(propertyName:String):com.adobe.fiber.styles.IStyle
     {
         switch(propertyName)
         {
            default:
            {
                return null;
            }
         }
     }
     
     /**
     * 
     * @inheritDoc 
     *  
     */  
     override public function getPropertyValidationFailureMessages(propertyName:String):Array
     {
         switch(propertyName)
         {
            case("basecurrency"):
            {
                return basecurrencyValidationFailureMessages;
            }
            case("rate"):
            {
                return rateValidationFailureMessages;
            }
            default:
            {
                return emptyArray;
            }
         }
     }

}

}
