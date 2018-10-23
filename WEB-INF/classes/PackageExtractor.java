//Program Adapted from Dr. Anthony J H Simon's lab presentation "Lab 05 Platform and Apps.pptx"
package com.auth;

import java.io.*;
import java.util.*;
import java.util.jar.*;

public class PackageExtractor {
	public static void extractWar(String warPath, String destination){
		try {
			JarFile jarFile = new JarFile(warPath);
			for(Enumeration<JarEntry> iterator = jarFile.entries();
					iterator.hasMoreElements();){
				JarEntry entry = iterator.nextElement();
				System.out.println("Processing: "+entry.getName());
				File outFile = new File(destination, entry.getName());
				if(!outFile.exists())
					outFile.getParentFile().mkdirs();
				if(!entry.isDirectory()){
					InputStream inStream = jarFile.getInputStream(entry);
					FileOutputStream outStream = new FileOutputStream(outFile);
					while (inStream.available() > 0) {
						outStream.write(inStream.read());
					}
					inStream.close();
					outStream.close();
				}
			}
			jarFile.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
