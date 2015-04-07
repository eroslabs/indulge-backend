/**
 * indulge-service
 * author vikas created on Apr 6, 2015
 */
package com.eros.service.util;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * @author vikas
 *
 */
public class EncryptionUtils {
	  
	    private static String  password = "ER0SLABSC01NDULG3";
		private static final String AES_MODE = "AES/CBC/PKCS5Padding";
		private static final String CHARSET = "UTF-8";
		private static final String HASH_ALGORITHM = "SHA-256";
		private static final byte[] ivBytes = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
		public static boolean DEBUG_LOG_ENABLED = false;
		protected static Log LOGGER = LogFactory.getLog(EncryptionUtils.class);
		public static void main(String[] args) {
			try {
				String input = "abcdefvikas@eroslabs.co";
				String encoded = EncryptionUtils.encrypt( input).toString();
				System.err.println(encoded);
				System.err.println(EncryptionUtils.decrypt( encoded).toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/**
		* Generates SHA256 hash of the password which is used as key
		*
		* @param password used to generated key
		* @return SHA256 of the password
		*/
		private static SecretKeySpec generateKey(final String password) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		final MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
		byte[] bytes = password.getBytes("UTF-8");
		digest.update(bytes, 0, bytes.length);
		byte[] key = digest.digest();
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, "AES");
		return secretKeySpec;
		}
		/**
		* Encrypt and encode message using 256-bit AES with key generated from password.
		*
		*
		* @param password used to generated key
		* @param message the thing you want to encrypt assumed String UTF-8
		* @return Base64 encoded CipherText
		* @throws GeneralSecurityException if problems occur during encryption
		*/
		public static String encrypt(String message)
		throws Exception {
		try {
		final SecretKeySpec key = generateKey(password);
		byte[] cipherText = encrypt(key, ivBytes, message.getBytes(CHARSET));
		//NO_WRAP is important as was getting \n at the end
		String encoded = Base64.encodeBase64String(cipherText);
		return encoded;
		} catch (Exception e) {
		throw new Exception(e);
		}
		}
	    
	    public static byte[] encrypt(final SecretKeySpec key, final byte[] iv, final byte[] message)
	    		throws Exception {
	    		final Cipher cipher = Cipher.getInstance(AES_MODE);
	    		IvParameterSpec ivSpec = new IvParameterSpec(iv);
	    		cipher.init(Cipher.ENCRYPT_MODE, key, ivSpec);
	    		byte[] cipherText = cipher.doFinal(message);
	    		return cipherText;
	    		}
	    
	    
	    
	    /**
		* Decrypt and decode ciphertext using 256-bit AES with key generated from password
		*
		* @param password used to generated key
		* @param base64EncodedCipherText the encrpyted message encoded with base64
		* @return message in Plain text (String UTF-8)
		* @throws GeneralSecurityException if there's an issue decrypting
		*/
		public static String decrypt(String base64EncodedCipherText)
		throws GeneralSecurityException {
		try {
		final SecretKeySpec key = generateKey(password);
		byte[] decodedCipherText = Base64.decodeBase64(base64EncodedCipherText);
		byte[] decryptedBytes = decrypt(key, ivBytes, decodedCipherText);
		String message = new String(decryptedBytes, CHARSET);
		return message;
		} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
		}
		return null;
		}
		/**
		* More flexible AES decrypt that doesn't encode
		*
		* @param key AES key typically 128, 192 or 256 bit
		* @param iv Initiation Vector
		* @param decodedCipherText in bytes (assumed it's already been decoded)
		* @return Decrypted message cipher text (not encoded)
		* @throws GeneralSecurityException if something goes wrong during encryption
		*/
		public static byte[] decrypt(final SecretKeySpec key, final byte[] iv, final byte[] decodedCipherText)
		throws GeneralSecurityException {
		final Cipher cipher = Cipher.getInstance(AES_MODE);
		IvParameterSpec ivSpec = new IvParameterSpec(iv);
		cipher.init(Cipher.DECRYPT_MODE, key, ivSpec);
		byte[] decryptedBytes = cipher.doFinal(decodedCipherText);
		return decryptedBytes;
		}
		
		/**
		* Converts byte array to hexidecimal useful for logging and fault finding
		* @param bytes
		* @return
		*/
		private static String bytesToHex(byte[] bytes) {
		final char[] hexArray = {'0', '1', '2', '3', '4', '5', '6', '7', '8',
		'9', 'A', 'B', 'C', 'D', 'E', 'F'};
		char[] hexChars = new char[bytes.length * 2];
		int v;
		for (int j = 0; j < bytes.length; j++) {
		v = bytes[j] & 0xFF;
		hexChars[j * 2] = hexArray[v >>> 4];
		hexChars[j * 2 + 1] = hexArray[v & 0x0F];
		}
		return new String(hexChars);
		}
}