package validate.stereotype;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import validate.MimeCheckerValidator;

@Retention(RUNTIME)
@Target({FIELD, METHOD})
@Constraint(validatedBy = {MimeCheckerValidator.class})
public @interface MimeChecker {
	public String contentType();
	public String message() default "{validate.stereotype.MimeChecker.message}";
	public Class<?>[] groups() default {};
	public Class<? extends Payload>[] payload() default {};
	
}
