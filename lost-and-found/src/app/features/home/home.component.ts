import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router'; // << add this
import { ItemsService } from '../../services/items.service';
import { Item } from '../../../models/Item';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit
{
  items: Item[] = [];
  loading = true;

  constructor(private itemsService: ItemsService) { }

  ngOnInit(): void
  {
    this.itemsService.getAll().subscribe({
      next: (data) =>
      {
        this.items = data;
        this.loading = false;
      },
      error: (err) =>
      {
        console.error('Error loading items', err);
        this.loading = false;
      }
    });
  }
}
