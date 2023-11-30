using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Newtonsoft.Json;


namespace A06
{
	public partial class _default : System.Web.UI.Page
	{




		[WebMethod]
		public static string GetFileList()
		{

			string filePath = "C:\\Users\\karandeep\\source\\A06\\A06\\MyFiles";
			string fileStatus;
			List<string> names = new List<string>();
			
			
			if (Directory.Exists(filePath))
			{

				fileStatus = "Success";
				// Gets file directory and all files, and appends the files found in MyFiles;
				string[] eachFilePaths = Directory.GetFiles(filePath);
				foreach (string file in eachFilePaths)
				{

					names.Add(Path.GetFileName(file));

				}
			}
			else
			{
				fileStatus = "Fail";
				
			}

			// return built string in json
			string[] namesInArray = names.ToArray();
			string jsonData = JsonConvert.SerializeObject(new {status = fileStatus, fileNames = namesInArray });
			return jsonData;
		}



	}
}