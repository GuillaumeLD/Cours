import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { PersonneService} from './services/personne.service';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [
  	PersonneService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
