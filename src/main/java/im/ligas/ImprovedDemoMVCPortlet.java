package im.ligas;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.util.ParamUtil;
import im.ligas.util.bridges.mvc.MVCPortlet;
import sun.text.resources.FormatData;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

/**
 * @author Miroslav Ligas
 */
public class ImprovedDemoMVCPortlet extends MVCPortlet {

	public void setModel(Map<String, Object> model, RenderRequest request) {
		model.put("defaultValue", "Attribute from controller(default model method): setModel");
		model.put("defaultObject", new FormDto("Object Value"));
	}

	public void customSetModel(Map<String, Object> model, RenderRequest request) {
		model.put("customValue", "Attribute from controller(default model method) customSetModel");
	}

	public void serveResourceJSP(ResourceRequest request, ResourceResponse response)
		throws IOException, PortletException {

		request.setAttribute("date",new Date());
		super.serveResourceJSP(request, response);
	}


	public void customResourceMethod(ResourceRequest request, ResourceResponse response) {
		PrintWriter out = null;
		try {
			response.setContentType("text/json");
			response.getWriter().write("Server time: " + new Date());
		} catch (IOException ex) {
			_LOG.error("IO Exception", ex);
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	public void handleForm(ActionRequest request, ActionResponse response) {
		long testValue = ParamUtil.getLong(request, "formValue");
		_LOG.error("sublimed value is " + testValue);

		if (testValue < 100) {
			SessionErrors.add(request, "Problema");
		}
	}


	@Override
	protected boolean isSessionErrorException(Throwable cause) {
		_LOG.error("exception", cause);
		return true;
	}

	Log _LOG = LogFactoryUtil.getLog(ImprovedDemoMVCPortlet.class);



}
