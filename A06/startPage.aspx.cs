using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text.Json;


namespace A06
{
	public partial class _default : System.Web.UI.Page
	{




		[WebMethod]
		public static string GetFileList()
		{
		
			string filePath = "MyFiles";
			string fileStatus;
			string[] names = {};
			
			if (File.Exists(filePath))
			{

				fileStatus = "Success";
				// Gets file directory and all files, and appends the files found in MyFiles;
				string[] eachFilePaths = Directory.GetFiles(filePath);
				foreach (string file in eachFilePaths)
				{

					names.Append(Path.GetFileName(file));



				}
			}
			else
			{
				fileStatus = "Fail";
				
			}

			// return built string in json
			string jsonData = JsonSerializer.Serialize(new {status = fileStatus, fileNames = names});
			return jsonData;
		}



	}
}