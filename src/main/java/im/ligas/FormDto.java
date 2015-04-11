package im.ligas;

/**
 * @author Miroslav Ligas
 */
public class FormDto {
	public String formValue;

	public FormDto(String formValue) {
		this.formValue = formValue;
	}

	@Override
	public String toString() {
		return formValue;
	}
}