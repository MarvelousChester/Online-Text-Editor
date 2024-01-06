/*
	Project Name: Online Text Editor
	Purpose: Contains web methods that jquery will post to for the text editor
	Date: 12/2/2023
*/
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


		/*
			Name : GetFileList()
			Purpose: Gets all the names of files in MyFiles and returns in json 
			parameters: NONE
			Return: JSON FORMAT {status: indicates if worked or not, array: contains the files names}
		*/
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

		/*
		Name :  GetFileContent
		Purpose: Gets all the names of files in MyFiles and returns in json 
		parameters: 
			string fileToLoad: File that needs to be loaded and sent back
		Return: JSON FORMAT {status: indicates if worked or not, content: contains the content of the file}
		*/
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
		Name :  GetFileContent
		Purpose: Checks if File exists, if file exists, then writes content passed from client and then sends back status in json format
		parameters: 
			string fileToSave: File Name that needs to be saved into MyFiles Directory
			string content: content that needs to be saved to the FileName
		Return: JSON FORMAT {status: indicates if worked or not}
		*/
		[WebMethod]
		public static string SaveFile(string fileToSave, string content)
		{

			string filePath = Path.Combine(HttpContext.Current.Server.MapPath("MyFiles"), fileToSave);
			string fileStatus;


			try
			{
				fileStatus = "Success";
				File.WriteAllText(filePath, content);

			}
			catch(Exception ex)
			{
				fileStatus = "Fail";
			}
			

			string jsonData = JsonConvert.SerializeObject(new { status = fileStatus });
			return jsonData;
		}
	}
}