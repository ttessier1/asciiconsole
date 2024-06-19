using System;

namespace Test
{
	
	public class Program
	{
		public static int Main(string[]arguments)
		{
			for(uint index=0;index<=255;index++)
			{
				
				char theChar=(char)index;
				if(!Char.IsControl(theChar))
				{
					Console.Write("{0} {1} [{2}] ",index.ToString("D3"),index.ToString("X2"),(char)index);
				}
				else
				{
					Console.Write("{0} {1} [{2}] ",index.ToString("D3"),index.ToString("X2")," ");
				}


				if(((index+1)%8)==0)
				{
					Console.WriteLine("");
				}
			}
			return 0;
		}
	}
};