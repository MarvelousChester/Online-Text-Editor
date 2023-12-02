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

			string filePath = HttpContext.Current.Server.MapPath("MyFiles");
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


		[WebMethod]
		public static string GetFileContent(string fileToLoad)
		{
			string filePath = Path.Combine(HttpContext.Current.Server.MapPath("MyFiles"), fileToLoad);
			string fileStatus;
			string fileContent;

			if (File.Exists(filePath))
			{

				fileStatus = "Success";
				// Gets file directory and all files, and appends the files found in MyFiles;
				fileContent = File.ReadAllText(filePath);
			}
			else
			{
				fileStatus = "Fail";
				fileContent = "File Not Found";
			}

			// return built string in json
			string jsonData = JsonConvert.SerializeObject(new { status = fileStatus, content = fileContent });
			return jsonData;
		}


		/*
		 * 
		 * Purposse: Checks if File exists, if file exists, then writes content passed from client and then sends back status in json format
		 * 
		 */

		[WebMethod]
		public static string SaveFile(string fileToSave, string content)
		{

			string filePath = Path.Combine(HttpContext.Current.Server.MapPath("MyFiles"), fileToSave);
			string fileStatus;
			
			if (File.Exists(filePath))
			{

				fileStatus = "Success";
				File.WriteAllText(filePath, content);
			}
			else
			{
				fileStatus = "Fail";
			}

			string jsonData = JsonConvert.SerializeObject(new { status = fileStatus });
			return jsonData;
		}
	}
}