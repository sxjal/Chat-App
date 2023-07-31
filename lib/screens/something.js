import React, { useState } from "react";
import {  getDownloadURL, uploadBytesResumable,ref} from "firebase/storage";
import { storage, database,app } from "./firebase";
import { Button, Form, Input, Select, message,Upload } from "antd";
import { UploadOutlined } from "@ant-design/icons";
import {ref as sRef,push, set } from "firebase/database";


const { Option } = Select;

function App() {
  const [progress, setProgress] = useState(0);

  // const handleFileUpload = (event) => {
  //   const file = event.target.files[0]; // Assuming you are handling a single file upload
  //   onFinish(file);
  // };
    const uploadProps = {
    beforeUpload: async (file) => {
      console.log("Before upload:", file);
      await uploadFiles(file);
      return false; // Prevent default upload behavior
    },
  };
  
  
  const onFinish = async (values, file) => {
    try {
      const downloadURL = await uploadFiles(file);
      console.log("Download URL:", downloadURL);
      console.log("After upload:", file);
  
      const { name, email, indosNo, phoneNo, certificateType, rank } = values.user;
      const formData = {
        name,
        email,
        indosNo,
        phoneNo,
        certificateType,
        rank,
        resumeURL: downloadURL,
      };
  
      const newEntryRef = push(sRef(database, "userFormData"));
      await set(newEntryRef, formData);
  
      console.log("Form values:", formData);
      console.log("New Entry Ref:", newEntryRef);
  
      // Show a success message to the user
      message.success("Form submitted successfully.");
    } catch (error) {
      console.error("Error uploading file:", error);
      // Error handling code...
    }
  };
  
  
  
  

  const uploadFiles = async (file) => {
    if (!file) return null;
    const storageRef = ref(storage, `files/${file.name}`);
    const uploadTask = uploadBytesResumable(storageRef, file);
  
    return new Promise((resolve, reject) => {
      uploadTask.on(
        "state_changed",
        (snapshot) => {
          const prog = Math.round(
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100
          );
          setProgress(prog);
        },
        (error) => {
          console.log("Error uploading file:", error);
          reject(error);
        },
        async () => {
          try {
            const downloadURL = await getDownloadURL(uploadTask.snapshot.ref);
            console.log("Resolved Download URL:", downloadURL);  
            resolve(downloadURL);
          } catch (error) {
            console.error("Error getting download URL:", error);
            reject(error);
          }
        }
      );
    });
    
    
  };
  


  return (
    <div className="App">
      <Form
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 14 }}
        layout="horizontal"
        onFinish={(values,file) => onFinish(values, file)}
        style={{ maxWidth: 600 }}
      >
        <Form.Item
          name={['user', 'name']}
          label="Name"
          rules={[
            {
              required: true,
              message: "Please input your name!",
            },
          ]}
        >
          <Input />
        </Form.Item>

        <Form.Item
          name={['user', 'email']}
          label="Email Address"
          rules={[
            {
              required: true,
              message: "Please input your email address!",
              type: "email",
            },
          ]}
        >
          <Input />
        </Form.Item>

        <Form.Item
          name={['user', 'indosNo']} // Make sure this matches the correct name
          label="INDOS NO"
          rules={[
            {
              required: true,
              message: "Please input your INDOS number!",
            },
          ]}
        >
          <Input />
        </Form.Item>


        <Form.Item
          name={['user', 'phoneNo']}
          label="Phone Number"
          rules={[
            {
              required: true,
              message: "Please input your phone number!",
            },
          ]}
        >
          <Input />
        </Form.Item>

        <Form.Item
          name={['user', 'certificateType']}
          label="Certificate Type"
          rules={[{ required: true, message: "Please select certificate type!" }]}
        >
          <Select>
            <Option value="COC">COC</Option>
            <Option value="Watchkeeping">Watchkeeping</Option>
            <Option value="COP">COP</Option>
          </Select>
        </Form.Item>

        <Form.Item
          name={['user', 'rank']}
          label="Rank"
          rules={[{ required: true, message: "Please select rank!" }]}
        >
          <Select>
            <Option value="Captain">Captain</Option>
            <Option value="First Officer">First Officer</Option>
            <Option value="Engineer">Engineer</Option>
          </Select>
        </Form.Item>

        <Form.Item label="Upload Resume" name="file">
          <Upload {...uploadProps}>
            <Button icon={<UploadOutlined />}>Click to Upload</Button>
          </Upload>
        </Form.Item>

        <h3>Uploaded {progress}%</h3>

        <Form.Item>
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </Form.Item>
      </Form>
    </div>
  );
}

export default App;