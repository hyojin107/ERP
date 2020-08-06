package validate;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import validate.stereotype.TelNumber;

public class TelNumberValidator implements ConstraintValidator<TelNumber, String>{

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		String regex = "0[\\d]{1,2}-[\\d]{3,4}-\\d{4}";
		if(value==null || value.isEmpty()) return true;
		else {
			return value.matches(regex);
		}
	}
	
}
