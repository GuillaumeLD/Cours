import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { AjouterComponent } from './ajouter/ajouter.component';

import { Routes, RouterModule } from '@angular/router';
import { CatalogueService } from './services/catalogue.service';
import { FormsModule} from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

const appRoutes  =[
      { path: 'ajouter', component:AjouterComponent },
      { path: '', component:HomeComponent }
];

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AjouterComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    FormsModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [
    CatalogueService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
