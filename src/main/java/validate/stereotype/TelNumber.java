package validate.stereotype;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import validate.TelNumberValidator;

@Target({ElementType.FIELD, ElementType.METHOD})
@Retention(RetentionPolicy.CLASS)
@Constraint(validatedBy = {TelNumberValidator.class})
public @interface TelNumber {
	public String message() default "{validate.stereotype.TelNumber.message}";
	public Class<?>[] groups() default {};
	public Class<? extends Payload>[] payload() default {};
}
