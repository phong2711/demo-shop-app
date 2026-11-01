import { Component, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent {
  @ViewChild('registerForm') registerForm!: NgForm;
  phoneNumber: string;
  password: string;
  retypePassword: string;
  fullName: string;
  dateOfBirth: Date;
  address: string;
  isAccepted: boolean;

  constructor() {
    this.phoneNumber = '';
    this.password = '';
    this.retypePassword = '';
    this.fullName = '';
    this.dateOfBirth = new Date();
    this.address = '';
    this.isAccepted = false;
  }

  onPhoneChange() {
    // Xử lý sự kiện khi giá trị của phoneNumber thay đổi
    console.log('Phone changed:', this.phoneNumber);
  }

  checkPasswordsMatch() {
    // Kiểm tra xem mật khẩu và gõ lại mật khẩu có khớp nhau không
    if (this.password !== this.retypePassword) {
      this.registerForm.form.controls['retypePassword'].setErrors({ 'passwordMismatch': true });
    } else {
      this.registerForm.form.controls['retypePassword'].setErrors(null);
    }
  }

  checkAge() {
    if (this.dateOfBirth) {
      const today = new Date();
      const birthDate = new Date(this.dateOfBirth);
      let age = today.getFullYear() - birthDate.getFullYear();
      const monthDiff = today.getMonth() - birthDate.getMonth();
      if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
      }

      if (age < 18) {
        this.registerForm.form.controls['dateOfBirth'].setErrors({ 'invalidAge': true });
      } else {
        this.registerForm.form.controls['dateOfBirth'].setErrors(null);
      }
    }
  }

  register() {
    // Xử lý logic đăng ký người dùng
    if (!this.isAccepted) {
      alert('Bạn phải đồng ý với các điều khoản và điều kiện.');
      return;
    }

    // Xử lý logic đăng ký tại đây
    console.log('Registering with:', {
      phoneNumber: this.phoneNumber,
      password: this.password,
      retypePassword: this.retypePassword,
      fullName: this.fullName,
      dateOfBirth: this.dateOfBirth,
      address: this.address,
      isAccepted: this.isAccepted
    });
  }
}
